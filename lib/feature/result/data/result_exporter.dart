import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:universal_html/html.dart' as html;

/// Builds a comprehensive .docx report from an [AnalysisResult]
class ResultExporter {
  static String _escapeXml(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');

  static Uint8List buildSimpleDocxBytes(AnalysisResult result) {
    final docXml = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
      ..writeln('<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">')
      ..writeln('<w:body>');

    // Helper functions for document structure
    void addHeading(String text, {int level = 1}) {
      final fontSize = level == 1 ? 32 : level == 2 ? 28 : 24;
      docXml.writeln(
        '<w:p><w:pPr><w:outlineLvl w:val="$level"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="$fontSize"/></w:rPr><w:t xml:space="preserve">${_escapeXml(text)}</w:t></w:r></w:p>',
      );
    }

    void addSubheading(String text) {
      docXml.writeln(
        '<w:p><w:pPr><w:outlineLvl w:val="3"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="22"/></w:rPr><w:t xml:space="preserve">${_escapeXml(text)}</w:t></w:r></w:p>',
      );
    }

    void addParagraph(String text, {bool bold = false, bool italic = false}) {
      docXml.write(
        '<w:p><w:r><w:rPr>',
      );
      if (bold) docXml.write('<w:b/>');
      if (italic) docXml.write('<w:i/>');
      docXml.writeln(
        '</w:rPr><w:t xml:space="preserve">${_escapeXml(text)}</w:t></w:r></w:p>',
      );
    }

    void addBulletPoint(String text) {
      docXml.writeln(
        '<w:p><w:pPr><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr></w:pPr><w:r><w:t xml:space="preserve">${_escapeXml(text)}</w:t></w:r></w:p>',
      );
    }

    void addDivider() {
      docXml.writeln('<w:p><w:r><w:t xml:space="preserve"> </w:t></w:r></w:p>');
    }

    // Document content
    addHeading('Multiverse Mentor Assessment Report', level: 1);
    addDivider();

    // Executive Summary
    addHeading('Executive Summary', level: 2);
    addParagraph(result.uiSummary);
    addDivider();

    // Detailed Analysis
    addHeading('Detailed Analysis', level: 2);
    
    addSubheading('Personality Profile');
    addParagraph('${result.personalityType} - ${result.personalityExplanation}', bold: true);
    addParagraph(result.personalityDetails);
    addDivider();

    addSubheading('Learning Style Analysis');
    addParagraph('Visual: ${result.learningStylePercentages['Visual'] ?? 0}%');
    addParagraph('Verbal: ${result.learningStylePercentages['Verbal'] ?? 0}%');
    addParagraph('Kinesthetic: ${result.learningStylePercentages['Kinesthetic'] ?? 0}%');
    addParagraph(result.learningStyleDetails);
    addDivider();

    addSubheading('Goals & Aspirations');
    if (result.goalsDetails.isEmpty) {
      addParagraph('No specific goals were detailed.');
    } else {
      for (var goal in result.goalsDetails) {
        addBulletPoint(goal);
      }
    }
    addDivider();

    addSubheading('Key Strengths');
    if (result.strengthsDetails.isEmpty) {
      addParagraph('No specific strengths were detailed.');
    } else {
      for (var strength in result.strengthsDetails) {
        addBulletPoint(strength);
      }
    }
    addDivider();

    addSubheading('Development Areas');
    if (result.developmentAreas.isEmpty) {
      addParagraph('No specific development areas were identified.');
    } else {
      for (var area in result.developmentAreas) {
        addBulletPoint(area);
      }
    }
    addDivider();

    // Recommendations Section
    addHeading('Recommendations', level: 2);
    
    addSubheading('Career Pathways');
    if (result.careerSuggestions.isEmpty) {
      addParagraph('No specific career suggestions were provided.');
    } else {
      for (var career in result.careerSuggestions) {
        addBulletPoint(career);
      }
    }
    addDivider();

    addSubheading('Skills Development');
    if (result.suggestedSkills.isEmpty) {
      addParagraph('No specific skills were suggested.');
    } else {
      for (var skill in result.suggestedSkills) {
        addBulletPoint(skill);
      }
    }
    addDivider();

    addSubheading('Freelance Opportunities');
    if (result.freelanceJobs['wordList']?.isEmpty ?? true) {
      addParagraph('No specific freelance opportunities were suggested.');
    } else {
      for (var job in result.freelanceJobs['wordList']!) {
        addBulletPoint(job);
      }
    }
    addDivider();

    // NEW: Practical Steps
    addSubheading('Practical Next Steps');
    if (result.practicalSteps.isEmpty) {
      addParagraph('No specific practical steps were provided.');
    } else {
      for (var step in result.practicalSteps) {
        addBulletPoint(step);
      }
    }
    addDivider();

    // NEW: Inspirational Quote
    addSubheading('Words of Inspiration');
    addParagraph('"${result.inspirationalQuote}"', italic: true);
    addDivider();

    // Document closing
    docXml.writeln('<w:sectPr><w:pgSz w:w="11906" w:h="16838"/></w:sectPr>');
    docXml.writeln('</w:body>');
    docXml.writeln('</w:document>');

    // Create the complete DOCX package
    return _createDocxPackage(docXml.toString());
  }

  static Uint8List _createDocxPackage(String documentXml) {
    // Content Types definition
    final contentTypes = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>
</Types>
''';

    // Relationships
    final rels = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
''';

    // Numbering for bullet points
    final numbering = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:abstractNum w:abstractNumId="0">
    <w:multiLevelType w:val="hybridMultilevel"/>
    <w:lvl w:ilvl="0">
      <w:numFmt w:val="bullet"/>
      <w:lvlText w:val="•"/>
      <w:lvlJc w:val="left"/>
      <w:pPr>
        <w:ind w:left="720" w:hanging="360"/>
      </w:pPr>
    </w:lvl>
  </w:abstractNum>
  <w:num w:numId="1">
    <w:abstractNumId w:val="0"/>
  </w:num>
</w:numbering>
''';

    // Core properties
    final core = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:creator>Multiverse Mentor</dc:creator>
  <dc:title>Assessment Report</dc:title>
  <dc:description>Detailed assessment report generated by Multiverse Mentor</dc:description>
</cp:coreProperties>
''';

    // Application properties
    final app = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>Multiverse Mentor</Application>
</Properties>
''';

    // Create archive with all necessary files
    final archive = Archive();
    
    // Add content types
    archive.addFile(ArchiveFile(
      '[Content_Types].xml',
      utf8.encode(contentTypes).length,
      utf8.encode(contentTypes),
    ));
    
    // Add relationships
    archive.addFile(ArchiveFile(
      '_rels/.rels',
      utf8.encode(rels).length,
      utf8.encode(rels),
    ));
    
    // Add core properties
    archive.addFile(ArchiveFile(
      'docProps/core.xml',
      utf8.encode(core).length,
      utf8.encode(core),
    ));
    
    // Add application properties
    archive.addFile(ArchiveFile(
      'docProps/app.xml',
      utf8.encode(app).length,
      utf8.encode(app),
    ));
    
    // Add numbering for bullet points
    archive.addFile(ArchiveFile(
      'word/numbering.xml',
      utf8.encode(numbering).length,
      utf8.encode(numbering),
    ));
    
    // Add main document
    archive.addFile(ArchiveFile(
      'word/document.xml',
      utf8.encode(documentXml).length,
      utf8.encode(documentXml),
    ));

    // Encode to ZIP format
    final encoder = ZipEncoder();
    final zipData = encoder.encode(archive)!;
    return Uint8List.fromList(zipData);
  }

  /// Triggers a browser download (web-only)
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