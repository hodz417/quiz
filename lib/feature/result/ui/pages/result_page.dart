import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/chat/data/models/analysis_result/analysis_result.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/services.dart' show rootBundle;

class ResultPage extends StatelessWidget {
  final AnalysisResult result;

  const ResultPage({super.key, required this.result});

  // Helper function to extract 2-word summaries
  String getTwoWordSummary(String text) {
    final words = text.split(' ');
    if (words.length <= 2) return text;
    return '${words[0]} ${words[1]}';
  }

  // Helper function to extract first word
  String getOneWordSummary(String text) {
    final words = text.split(' ');
    return words.isNotEmpty ? words[0] : text;
  }

  Future<void> _downloadWordFile() async {
    try {
      // Load template
      final data = await rootBundle.load('assets/template.docx');
      final bytes = data.buffer.asUint8List();
      final docx = await DocxTemplate.fromBytes(bytes);

      // Populate content with full details
      Content c = Content();
      c.add(TextContent('summary', result.summary));
      c.add(TextContent('personality', result.personality));
      c.add(TextContent('learning_visual', '${result.learningStylePercentages['Visual'] ?? 0}% بصري'));
      c.add(TextContent('learning_verbal', '${result.learningStylePercentages['Verbal'] ?? 0}% لفظي'));
      c.add(TextContent('learning_kinesthetic', '${result.learningStylePercentages['Kinesthetic'] ?? 0}% حركي'));
      
      // Add all goals, strengths, etc. with full details
      c.add(ListContent('goals', 
          result.goals.map((g) => PlainContent(TextContent('goal', g) as String)).toList()));
      c.add(ListContent('strengths', 
          result.strengths.map((s) => PlainContent(TextContent('strength', s) as String)).toList()));
      c.add(ListContent('development_areas', 
          result.developmentAreas.map((d) => PlainContent(TextContent('area', d) as String)).toList()));
      c.add(ListContent('career_suggestions', 
          result.careerSuggestions.map((c) => PlainContent(TextContent('suggestion', c) as String)).toList()));

      // Generate docx
      final docGenerated = await docx.generate(c);
      final fileBytes = docGenerated ?? bytes;

      // Download or save
      if (kIsWeb) {
        final blob = html.Blob([fileBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..download = 'تقرير_التقييم_الشامل.docx'
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/تقرير_التقييم_الشامل.docx';
        await File(path).writeAsBytes(fileBytes);
        // Show success message
       
      }
    } catch (e) {
      // Show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final containerWidth = mediaQuery.size.width > 800 
        ? mediaQuery.size.width * 0.5 
        : mediaQuery.size.width * 0.95;

    // Prepare data with 2-word summaries for UI
    final List<Map<String, dynamic>> resultsData = [
      {
        'title': 'الشخصية',
        'icon': Icons.psychology,
        'iconColor': AppColors.blueColor,
        'gradientColors': [const Color(0XFFE7F3FF), Colors.white],
        'items': [
          {
            'value': getTwoWordSummary(result.personality), 
            'label': '',
            'fullValue': result.personality
          },
        ],
      },
      {
        'title': 'التعلم',
        'icon': Icons.school,
        'iconColor': const Color(0XFF16A34A),
        'gradientColors': [const Color(0XFFDCFCE7), Colors.white],
        'items': [
          {
            'value': '${result.learningStylePercentages['Visual'] ?? 0}%', 
            'label': 'بصري',
            'fullValue': '${result.learningStylePercentages['Visual'] ?? 0}% بصري'
          },
          {
            'value': '${result.learningStylePercentages['Verbal'] ?? 0}%', 
            'label': 'لفظي',
            'fullValue': '${result.learningStylePercentages['Verbal'] ?? 0}% لفظي'
          },
          {
            'value': '${result.learningStylePercentages['Kinesthetic'] ?? 0}%', 
            'label': 'حركي',
            'fullValue': '${result.learningStylePercentages['Kinesthetic'] ?? 0}% حركي'
          },
        ],
      },
      {
        'title': 'الأهداف',
        'icon': Icons.flag,
        'iconColor': Colors.black,
        'gradientColors': [Colors.white, Colors.white],
        'items': result.goals.take(3).map((g) => {
          'value': getTwoWordSummary(g),
          'label': '',
          'fullValue': g
        }).toList(),
      },
      {
        'title': 'نقاط القوة',
        'icon': Icons.star,
        'iconColor': Colors.amber,
        'gradientColors': [Colors.white, Colors.white],
        'items': result.strengths.take(3).map((s) => {
          'value': getTwoWordSummary(s),
          'label': '',
          'fullValue': s
        }).toList(),
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.kPrimaryBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Container(
              width: containerWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0XFFDCFCE7),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 40,
                            color: Color(0XFF16A34A),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Center(
                        child: Text(
                          "تهانينا!",
                          style: AppTextStyles.font26BoldBlack,
                        ),
                      ),
                      const Gap(5),
                      Center(
                        child: Text(
                          getTwoWordSummary(result.summary),
                          style: AppTextStyles.font17Grey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resultsData.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3.0,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return ResultCardItem(
                            title: resultsData[index]['title'],
                            icon: resultsData[index]['icon'],
                            iconColor: resultsData[index]['iconColor'],
                            gradientColors: List<Color>.from(resultsData[index]['gradientColors']),
                            items: List<Map<String, String>>.from(resultsData[index]['items']),
                          );
                        },
                      ),
                      const Gap(10),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [const Color(0xFF0068CC), const Color(0xFF00CB9A)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.star_outline, color: Colors.white, size: 20),
                                const Gap(4),
                                const Text(
                                  "التوصيات",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: result.careerSuggestions.take(4).map((suggestion) {
                                return _buildTopicCard(
                                  getOneWordSummary(suggestion),
                                  getTwoWordSummary(suggestion),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [const Color(0xFF0068CC), const Color(0xFF00CB9A)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: _downloadWordFile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              'تحميل التقرير',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const Gap(5),
                      const Center(
                        child: Text(
                          'تقرير مفصل بكافة النتائج',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(String title, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Gap(2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ResultCardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradientColors;
  final List<Map<String, String>> items;

  const ResultCardItem({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.gradientColors,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 24),
                  const Gap(5),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.font20SemiBoldBlack.copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (items[i]['label']?.isNotEmpty ?? false)
                          Flexible(
                            child: Text(
                              items[i]['label'] ?? '',
                              style: AppTextStyles.font14Grey.copyWith(fontSize: 12),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const Gap(4),
                        Flexible(
                          child: Text(
                            items[i]['value'] ?? '',
                            style: AppTextStyles.font14Grey.copyWith(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (i != items.length - 1) const SizedBox(height: 4),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}