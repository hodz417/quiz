import 'dart:convert' show utf8;
import 'package:archive/archive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart'; // Added for rootBundle
import 'package:mentor/core/utils/extensions/l10n_extension.dart';
import 'package:mentor/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:universal_html/html.dart' as html;

/// Builds a comprehensive .docx report from an [AnalysisResult]
class ResultExporter {
  static String _escapeXml(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');

  static String _cleanResourceField(String s) {
    if (s.isEmpty) return '';
    // removes "Resource found via search for" and anything that follows on that line
    return s
        .replaceAll(
          RegExp(
            r'Resource found via search for[:\s]*.*',
            caseSensitive: false,
          ),
          '',
        )
        .trim();
  }

  /// Build the docx bytes. Requires [context] to access localized strings.
  static Future<Uint8List> buildSimpleDocxBytes(
    BuildContext context,
    AnalysisResult result,
  ) async {
    final l10n = context.l10n;

    // Load logo image
    Uint8List? logoBytes;
    try {
      final byteData = await rootBundle.load("assets/images/mentor_logo.png");
      logoBytes = byteData.buffer.asUint8List();
    } catch (e) {
      print("Error loading logo: $e");
    }

    final docXml = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
      ..writeln(
        '<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">',
      )
      ..writeln('<w:body>');

    // Helper functions for document structure
    void addHeading(String text, {int level = 1}) {
      final fontSize = level == 1
          ? 32
          : level == 2
          ? 28
          : 24;
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
      docXml.write('<w:p><w:r><w:rPr>');
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

    void addImage(Uint8List imageBytes) {
      // Width: 3 inches (3 * 914400 = 2743200 EMUs)
      // Height reduced to 1 inch (1 * 914400 = 914400 EMUs)
      docXml.writeln('''
  <w:p>
    <w:pPr>
      <w:jc w:val="center"/> <!-- Center the image -->
    </w:pPr>
    <w:r>
      <w:drawing>
        <wp:inline distT="0" distB="0" distL="0" distR="0">
          <wp:extent cx="2743200" cy="914400"/> <!-- Width x Reduced Height -->
          <wp:docPr id="1" name="Logo"/>
          <wp:cNvGraphicFramePr>
            <a:graphicFrameLocks noChangeAspect="1"/>
          </wp:cNvGraphicFramePr>
          <a:graphic>
            <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
              <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                <pic:nvPicPr>
                  <pic:cNvPr id="0" name="Logo"/>
                  <pic:cNvPicPr/>
                </pic:nvPicPr>
                <pic:blipFill>
                  <a:blip r:embed="rIdLogo"/>
                  <a:stretch>
                    <a:fillRect/>
                  </a:stretch>
                </pic:blipFill>
                <pic:spPr>
                  <a:xfrm>
                    <a:off x="0" y="0"/>
                    <a:ext cx="2743200" cy="914400"/> <!-- Width x Reduced Height -->
                  </a:xfrm>
                  <a:prstGeom prst="rect">
                    <a:avLst/>
                  </a:prstGeom>
                </pic:spPr>
              </pic:pic>
            </a:graphicData>
          </a:graphic>
        </wp:inline>
      </w:drawing>
    </w:r>
  </w:p>
''');
    }

    // Add logo if available
    if (logoBytes != null) {
      addImage(logoBytes);
      addDivider();
    }

    // Document content using localized strings
    addHeading(l10n.multiverseMentorAssessmentReport, level: 1);
    addDivider();

    // Executive Summary
    addHeading(l10n.executiveSummary, level: 2);
    addParagraph(result.uiSummary);
    addDivider();

    // Detailed Analysis
    addHeading(l10n.detailedAnalysis, level: 2);

    addSubheading(l10n.personalityProfile);
    addParagraph(
      '${result.personalityType} - ${result.personalityExplanation}',
      bold: true,
    );
    addParagraph(result.personalityDetails);
    addDivider();

    addSubheading(l10n.learningStyleAnalysis);
    addParagraph(
      '${l10n.visual}: ${result.learningStylePercentages['Visual'] ?? 0}%',
    );
    addParagraph(
      '${l10n.verbal}: ${result.learningStylePercentages['Verbal'] ?? 0}%',
    );
    addParagraph(
      '${l10n.kinesthetic}: ${result.learningStylePercentages['Kinesthetic'] ?? 0}%',
    );
    addParagraph(result.learningStyleDetails);
    addDivider();

    addSubheading(l10n.goalsAspirations);
    if (result.goalsDetails.isEmpty) {
      addParagraph(l10n.noSpecificGoals);
    } else {
      for (var goal in result.goalsDetails) {
        addBulletPoint(goal);
      }
    }
    addDivider();

    addSubheading(l10n.keyStrengths);
    if (result.strengthsDetails.isEmpty) {
      addParagraph(l10n.noSpecificStrengths);
    } else {
      for (var strength in result.strengthsDetails) {
        addBulletPoint(strength);
      }
    }
    addDivider();

    addSubheading(l10n.developmentAreas);
    if (result.developmentAreas.isEmpty) {
      addParagraph(l10n.noSpecificDevelopmentAreas);
    } else {
      for (var area in result.developmentAreas) {
        addBulletPoint(area);
      }
    }
    addDivider();

    // Recommendations Section
    addHeading(l10n.recommendations, level: 2);

    addSubheading(l10n.careerPathways);
    if (result.careerSuggestions.isEmpty) {
      addParagraph(l10n.noSpecificCareerSuggestions);
    } else {
      for (var career in result.careerSuggestions) {
        addBulletPoint(career);
      }
    }
    addDivider();

    addSubheading(l10n.skillsDevelopment);
    if (result.suggestedSkills.isEmpty) {
      addParagraph(l10n.noSpecificSkillsSuggested);
    } else {
      for (var skill in result.suggestedSkills) {
        addBulletPoint(skill);
      }
    }
    addDivider();

    addSubheading(l10n.freelanceOpportunities);
    if (result.freelanceJobs['wordList']?.isEmpty ?? true) {
      addParagraph(l10n.noSpecificFreelanceOpportunities);
    } else {
      for (var job in result.freelanceJobs['wordList']!) {
        addBulletPoint(job);
      }
    }
    addDivider();

    // Practical Steps
    addSubheading(l10n.practicalNextSteps);
    if (result.practicalSteps.isEmpty) {
      addParagraph(l10n.noSpecificPracticalSteps);
    } else {
      for (var step in result.practicalSteps) {
        addBulletPoint(step);
      }
    }
    addDivider();

    // Learning Resources - UPDATED SECTION
    addSubheading(l10n.learningResources);
    if (result.learningResources.isEmpty) {
      addParagraph(l10n.noLearningResources);
    } else {
      addParagraph(l10n.learningResourcesDescription);
      addDivider();

      for (var resource in result.learningResources) {
        final name = _cleanResourceField(
          resource['name'] ?? 'Untitled Resource',
        );
        final type = _cleanResourceField(resource['type'] ?? '');
        final url = _cleanResourceField(resource['url'] ?? '');
        final description = _cleanResourceField(resource['description'] ?? '');
        final lastUpdated = _cleanResourceField(resource['lastUpdated'] ?? '');

        addSubheading(name);
        if (type.isNotEmpty) {
          addParagraph('${l10n.resourceType}: $type');
        }
        if (description.isNotEmpty) {
          addParagraph(description);
        }
        if (url.isNotEmpty) {
          addParagraph('${l10n.resourceUrl}: $url');
        }
        if (lastUpdated.isNotEmpty) {
          addParagraph('${l10n.lastUpdated}: $lastUpdated');
        }
        addDivider();
      }
    }

    // Roadmap Section - NEW SECTION
    addSubheading(l10n.learningRoadmap);
    if (result.roadmap.isEmpty) {
      addParagraph(l10n.noRoadmapAvailable);
    } else {
      // Level A (Beginner)
      if (result.roadmap['levelA']?.isNotEmpty ?? false) {
        addSubheading('${l10n.beginnerLevel} (3-6 ${l10n.months})');
        for (var step in result.roadmap['levelA']!) {
          addBulletPoint(step);
        }
        addDivider();
      }

      // Level B (Intermediate)
      if (result.roadmap['levelB']?.isNotEmpty ?? false) {
        addSubheading('${l10n.intermediateLevel} (6-12 ${l10n.months})');
        for (var step in result.roadmap['levelB']!) {
          addBulletPoint(step);
        }
        addDivider();
      }

      // Level C (Advanced)
      if (result.roadmap['levelC']?.isNotEmpty ?? false) {
        addSubheading('${l10n.advancedLevel} (12-24 ${l10n.months})');
        for (var step in result.roadmap['levelC']!) {
          addBulletPoint(step);
        }
        addDivider();
      }
    }

    // Inspirational Quote
    addSubheading(l10n.wordsOfInspiration);
    addParagraph('"${result.inspirationalQuote}"', italic: true);
    addDivider();

    // Document closing
    docXml.writeln('<w:sectPr><w:pgSz w:w="11906" w:h="16838"/></w:sectPr>');
    docXml.writeln('</w:body>');
    docXml.writeln('</w:document>');

    // Create the complete DOCX package and pass core properties from l10n
    return _createDocxPackage(
      docXml.toString(),
      l10n.creatorName,
      l10n.assessmentReportTitle,
      l10n.detailedReportDescription,
      logoBytes: logoBytes,
    );
  }

  static Uint8List _createDocxPackage(
    String documentXml,
    String creator,
    String title,
    String description, {
    Uint8List? logoBytes,
  }) {
    // Content Types definition
    final contentTypes = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Default Extension="png" ContentType="image/png"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>
</Types>
''';

    // Main relationships
    final rels = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
''';

    // Document relationships
    final documentRels = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
      ..writeln(
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
      )
      ..writeln(
        '<Relationship Id="rIdNumbering" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>',
      );

    if (logoBytes != null) {
      documentRels.writeln(
        '<Relationship Id="rIdLogo" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/logo.png"/>',
      );
    }

    documentRels.writeln('</Relationships>');

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

    // Core properties (use passed localized strings)
    final core =
        '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:creator>${_escapeXml(creator)}</dc:creator>
  <dc:title>${_escapeXml(title)}</dc:title>
  <dc:description>${_escapeXml(description)}</dc:description>
</cp:coreProperties>
''';

    // Application properties
    final app =
        '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>${_escapeXml(creator)}</Application>
</Properties>
''';

    // Create archive with all necessary files
    final archive = Archive();

    // Add content types
    archive.addFile(
      ArchiveFile(
        '[Content_Types].xml',
        utf8.encode(contentTypes).length,
        utf8.encode(contentTypes),
      ),
    );

    // Add relationships
    archive.addFile(
      ArchiveFile('_rels/.rels', utf8.encode(rels).length, utf8.encode(rels)),
    );

    // Add document relationships
    archive.addFile(
      ArchiveFile(
        'word/_rels/document.xml.rels',
        utf8.encode(documentRels.toString()).length,
        utf8.encode(documentRels.toString()),
      ),
    );

    // Add core properties
    archive.addFile(
      ArchiveFile(
        'docProps/core.xml',
        utf8.encode(core).length,
        utf8.encode(core),
      ),
    );

    // Add application properties
    archive.addFile(
      ArchiveFile(
        'docProps/app.xml',
        utf8.encode(app).length,
        utf8.encode(app),
      ),
    );

    // Add numbering for bullet points
    archive.addFile(
      ArchiveFile(
        'word/numbering.xml',
        utf8.encode(numbering).length,
        utf8.encode(numbering),
      ),
    );

    // Add main document
    archive.addFile(
      ArchiveFile(
        'word/document.xml',
        utf8.encode(documentXml).length,
        utf8.encode(documentXml),
      ),
    );

    // Add logo image if available
    if (logoBytes != null) {
      archive.addFile(
        ArchiveFile('word/media/logo.png', logoBytes.length, logoBytes),
      );
    }

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
