// lib/feature/result/ui/docx_generator_web.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:quiz/feature/chat/data/models/analysis_result/analysis_result.dart';
import 'package:universal_html/html.dart' as html;

/// Build a minimal Word (docx) file bytes from plain text sections.
/// The produced docx is very simple (plain paragraphs).
Uint8List buildSimpleDocxBytes(AnalysisResult result) {
  // Helper to escape XML characters
  String esc(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');

  // Prepare document.xml content (WordprocessingML)
  final docXml = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:p><w:r><w:t xml:space="preserve">${esc("تقرير التقييم")}</w:t></w:r></w:p>

    <w:p><w:r><w:t xml:space="preserve">${esc("الملخص:")}</w:t></w:r></w:p>
    <w:p><w:r><w:t xml:space="preserve">${esc(result.summary)}</w:t></w:r></w:p>

    <w:p><w:r><w:t xml:space="preserve">${esc("الشخصية:")}</w:t></w:r></w:p>
    <w:p><w:r><w:t xml:space="preserve">${esc(result.personality)}</w:t></w:r></w:p>

    <w:p><w:r><w:t xml:space="preserve">${esc("أسلوب التعلم:")}</w:t></w:r></w:p>
    <w:p><w:r><w:t xml:space="preserve">${esc("بصري: ${result.learningStylePercentages['Visual'] ?? 0}%")}</w:t></w:r></w:p>
    <w:p><w:r><w:t xml:space="preserve">${esc("لفظي: ${result.learningStylePercentages['Verbal'] ?? 0}%")}</w:t></w:r></w:p>
    <w:p><w:r><w:t xml:space="preserve">${esc("حركي: ${result.learningStylePercentages['Kinesthetic'] ?? 0}%")}</w:t></w:r></w:p>

    <w:p><w:r><w:t xml:space="preserve">${esc("الأهداف:")}</w:t></w:r></w:p>
    ${result.goals.map((g) => '<w:p><w:r><w:t xml:space="preserve">${esc("- $g")}</w:t></w:r></w:p>').join("\n")}

    <w:p><w:r><w:t xml:space="preserve">${esc("نقاط القوة:")}</w:t></w:r></w:p>
    ${result.strengths.map((s) => '<w:p><w:r><w:t xml:space="preserve">${esc("- $s")}</w:t></w:r></w:p>').join("\n")}

    <w:p><w:r><w:t xml:space="preserve">${esc("مجالات التطوير:")}</w:t></w:r></w:p>
    ${result.developmentAreas.map((d) => '<w:p><w:r><w:t xml:space="preserve">${esc("- $d")}</w:t></w:r></w:p>').join("\n")}

    <w:p><w:r><w:t xml:space="preserve">${esc("اقتراحات مهنية:")}</w:t></w:r></w:p>
    ${result.careerSuggestions.map((c) => '<w:p><w:r><w:t xml:space="preserve">${esc("- $c")}</w:t></w:r></w:p>').join("\n")}

    <w:sectPr><w:pgSz w:w="11906" w:h="16838"/></w:sectPr>
  </w:body>
</w:document>
''';

  // Minimal [Content_Types].xml
  final contentTypes = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>
''';

  // _rels/.rels
  final rels = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
''';

  // docProps/core.xml (minimal, uses Dublin Core)
  final core = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:creator>Multiverse Mentor</dc:creator>
  <dc:title>تقرير التقييم</dc:title>
  <dc:description>تقرير التقييم المولد بواسطة التطبيق</dc:description>
</cp:coreProperties>
''';

  // docProps/app.xml
  final app = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>Multiverse Mentor</Application>
</Properties>
''';

  // Build archive
  final archive = Archive();

  archive.addFile(ArchiveFile('[Content_Types].xml', utf8.encode(contentTypes).length, utf8.encode(contentTypes)));
  archive.addFile(ArchiveFile('_rels/.rels', utf8.encode(rels).length, utf8.encode(rels)));
  archive.addFile(ArchiveFile('docProps/core.xml', utf8.encode(core).length, utf8.encode(core)));
  archive.addFile(ArchiveFile('docProps/app.xml', utf8.encode(app).length, utf8.encode(app)));
  archive.addFile(ArchiveFile('word/document.xml', utf8.encode(docXml).length, utf8.encode(docXml)));

  // Encode ZIP
  final encoder = ZipEncoder();
  final zipData = encoder.encode(archive)!; // List<int>

  return Uint8List.fromList(zipData);
}

/// Trigger browser download (Web only)
void downloadDocxInBrowser(Uint8List bytes, String filename) {
  final blob = html.Blob([bytes], 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement;
  anchor.href = url;
  anchor.download = filename;
  anchor.style.display = 'none';
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
  Future.delayed(const Duration(milliseconds: 300), () => html.Url.revokeObjectUrl(url));
}
