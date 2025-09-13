import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:universal_html/html.dart' as html;



/// Builds a minimal .docx (WordprocessingML) archive from an [AnalysisResult].
/// Returns the bytes ready to be written to disk or offered as a download.
class ResultExporter {
  static String _escapeXml(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '<')
      .replaceAll('>', '>')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');

  static Uint8List buildSimpleDocxBytes(AnalysisResult r) {
    final header = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
    final docXml = StringBuffer()
      ..writeln(header)
      ..writeln(
        '<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">',
      )
      ..writeln('<w:body>');

    void addParagraph(String text) {
      docXml.writeln(
        '<w:p><w:r><w:t xml:space="preserve">${_escapeXml(text)}</w:t></w:r></w:p>',
      );
    }

    void addHeading(String text, {int level = 1}) {
      // Simple heading using bold and size, as full styles are complex in raw XML
      docXml.writeln(
        '<w:p><w:pPr><w:outlineLvl w:val="$level"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="${40 - (level * 4)}"/></w:rPr><w:t xml:space="preserve">${_escapeXml(text)}</w:t></w:r></w:p>',
      );
    }

    addHeading('Multiverse Mentor Assessment Report');
    addParagraph('');
    addHeading('Executive Summary', level: 2);
    addParagraph(r.uiSummary); // Use concise UI summary here or detailed if preferred
    addParagraph('');

    addHeading('Detailed Profile Analysis', level: 1);
    addHeading('Personality Type', level: 2);
    addParagraph('${r.personalityType} - ${r.personalityExplanation}');
    addParagraph(r.personalityDetails); // Add detailed personality description

    addHeading('Learning Style', level: 2);
    addParagraph('Visual: ${r.learningStylePercentages['Visual'] ?? 0}%');
    addParagraph('Verbal: ${r.learningStylePercentages['Verbal'] ?? 0}%');
    addParagraph('Kinesthetic: ${r.learningStylePercentages['Kinesthetic'] ?? 0}%');
    addParagraph(r.learningStyleDetails); // Add detailed learning style explanation

    addHeading('Goals', level: 2);
    if (r.goalsDetails.isEmpty) {
      addParagraph('No specific goals were detailed.');
    } else {
      for (var g in r.goalsDetails) {
        addParagraph('- $g');
      }
    }

    addHeading('Strengths', level: 2);
    if (r.strengthsDetails.isEmpty) {
      addParagraph('No specific strengths were detailed.');
    } else {
      for (var s in r.strengthsDetails) {
        addParagraph('- $s');
      }
    }

    addHeading('Areas for Development', level: 2);
    if (r.developmentAreas.isEmpty) {
      addParagraph('No specific development areas were identified.');
    } else {
      for (var d in r.developmentAreas) {
        addParagraph('- $d');
      }
    }

    addHeading('Career Suggestions', level: 2);
    if (r.careerSuggestions.isEmpty) {
      addParagraph('No specific career suggestions were provided.');
    } else {
      for (var c in r.careerSuggestions) {
        addParagraph('- $c');
      }
    }

    addHeading('Suggested Skills to Learn', level: 2);
    if (r.suggestedSkills.isEmpty) {
      addParagraph('No specific skills were suggested.');
    } else {
      for (var s in r.suggestedSkills) {
        addParagraph('- $s');
      }
    }

    addHeading('Freelance Opportunities', level: 2);
    if (r.freelanceJobs['wordList']?.isEmpty ?? true) {
      addParagraph('No specific freelance opportunities were suggested.');
    } else {
      for (var job in r.freelanceJobs['wordList']!) {
        addParagraph('- $job');
      }
    }

    // closing
    docXml.writeln('<w:sectPr><w:pgSz w:w="11906" w:h="16838"/></w:sectPr>');
    docXml.writeln('</w:body>');
    docXml.writeln('</w:document>');
    final documentXml = docXml.toString();

final contentTypes = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>
''';

    final rels =
        '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
''';

    final core =
        """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:creator>Multiverse Mentor</dc:creator>
  <dc:title>Assessment Report</dc:title>
  <dc:description>Detailed assessment report generated by the app</dc:description>
</cp:coreProperties>
""";

    final app =
        '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>Multiverse Mentor</Application>
</Properties>
''';

    final archive = Archive();
    archive.addFile(
      ArchiveFile(
        '[Content_Types].xml',
        utf8.encode(contentTypes).length,
        utf8.encode(contentTypes),
      ),
    );
    archive.addFile(
      ArchiveFile('_rels/.rels', utf8.encode(rels).length, utf8.encode(rels)),
    );
    archive.addFile(
      ArchiveFile(
        'docProps/core.xml',
        utf8.encode(core).length,
        utf8.encode(core),
      ),
    );
    archive.addFile(
      ArchiveFile(
        'docProps/app.xml',
        utf8.encode(app).length,
        utf8.encode(app),
      ),
    );
    archive.addFile(
      ArchiveFile(
        'word/document.xml',
        utf8.encode(documentXml).length,
        utf8.encode(documentXml),
      ),
    );

    final encoder = ZipEncoder();
    final zipData = encoder.encode(archive)!;
    return Uint8List.fromList(zipData);
  }

  /// Triggers a browser download (web-only). Accepts the doc bytes and the
  /// suggested filename (e.g. "assessment_report.docx").
  static void downloadDocxInBrowser(Uint8List bytes, String filename) {
    final blob = html.Blob(
      [bytes],
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    );
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement;
    anchor.href = url;
    anchor.download = filename;
    anchor.style.display = 'none';
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    Future.delayed(
      const Duration(milliseconds: 300),
      () => html.Url.revokeObjectUrl(url),
    );
  }
}