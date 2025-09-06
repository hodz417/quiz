import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:quiz/feature/result/data/result_exporter.dart';
import 'package:quiz/feature/result/ui/widgets/result_card.dart';
import 'package:quiz/feature/result/ui/widgets/topic_chip.dart';

class ResultPageWeb extends StatelessWidget {
  final AnalysisResult result;
  const ResultPageWeb({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final containerWidth = mediaQuery.size.width > 900
        ? mediaQuery.size.width * 0.55
        : mediaQuery.size.width * 0.95;

    final resultsData = <Map<String, dynamic>>[
      {
        'title': 'Personality',
        'icon': Icons.psychology,
        'iconColor': AppColors.blueColor,
        'gradient': [const Color(0xFFE7F3FF), Colors.white],
        'items': [
          {
            'value': WordHelper.shortPreview(result.personality),
            'label': '',
            'full': result.personality,
          },
        ],
      },
      {
        'title': 'Learning',
        'icon': Icons.school,
        'iconColor': const Color(0xFF16A34A),
        'gradient': [const Color(0xFFDCFCE7), Colors.white],
        'items': [
          {
            'value': '${result.learningStylePercentages['Visual'] ?? 0}%',
            'label': 'Visual',
            'full': '${result.learningStylePercentages['Visual'] ?? 0}% Visual',
          },
          {
            'value': '${result.learningStylePercentages['Verbal'] ?? 0}%',
            'label': 'Verbal',
            'full': '${result.learningStylePercentages['Verbal'] ?? 0}% Verbal',
          },
          {
            'value': '${result.learningStylePercentages['Kinesthetic'] ?? 0}%',
            'label': 'Kinesthetic',
            'full':
                '${result.learningStylePercentages['Kinesthetic'] ?? 0}% Kinesthetic',
          },
        ],
      },
      {
        'title': 'Goals',
        'icon': Icons.flag,
        'iconColor': Colors.black,
        'gradient': [Colors.white, Colors.white],
        'items': result.goals
            .take(3)
            .map(
              (g) => {
                'value': WordHelper.shortPreview(g),
                'label': '',
                'full': g,
              },
            )
            .toList(),
      },
      {
        'title': 'Strengths',
        'icon': Icons.star,
        'iconColor': Colors.amber,
        'gradient': [Colors.white, Colors.white],
        'items': result.strengths
            .take(3)
            .map(
              (s) => {
                'value': WordHelper.shortPreview(s),
                'label': '',
                'full': s,
              },
            )
            .toList(),
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.kPrimaryBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Center(
            child: Container(
              width: containerWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFFDCFCE7),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Color(0xFF16A34A),
                            size: 40,
                          ),
                        ),
                      ),
                      const Gap(12),
                      Center(
                        child: Text(
                          'Congratulations!',
                          style: AppTextStyles.font30BoldBlack,
                        ),
                      ),
                      const Gap(8),
                      Center(
                        child: Text(
                          WordHelper.shortPreview(result.summary),
                          style: AppTextStyles.font17Grey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(14),
                      // Responsive card layout
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          // For mobile devices - vertical layout

                          if (sizingInformation.deviceScreenType ==
                              DeviceScreenType.mobile) {
                            return Column(
                              children: [
                                for (var item in resultsData)
                                  ResultCard(
                                    title: item['title'],
                                    icon: item['icon'],
                                    iconColor: item['iconColor'],
                                    gradient: List<Color>.from(
                                      item['gradient'],
                                    ),
                                    items: List<Map<String, String>>.from(
                                      (item['items'] as List).map((m) {
                                        final v = (m['value'] ?? '').toString();
                                        final short = v
                                            .split(RegExp(r'\s+'))
                                            .take(2)
                                            .join(' ');
                                        return {
                                          'value': short,
                                          'label': (m['label'] ?? '')
                                              .toString(),
                                          'full': (m['full'] ?? '').toString(),
                                        };
                                      }).toList(),
                                    ),
                                  ),
                                const Gap(10),
                              ],
                            );
                          }
                          // For desktop/tablet - grid layout
                          else {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: resultsData.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3.2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                              itemBuilder: (context, idx) {
                                final item = resultsData[idx];
                                final items = (item['items'] as List).map((m) {
                                  final v = (m['value'] ?? '').toString();
                                  final short = v
                                      .split(RegExp(r'\s+'))
                                      .take(2)
                                      .join(' ');
                                  return {
                                    'value': short,
                                    'label': (m['label'] ?? '').toString(),
                                    'full': (m['full'] ?? '').toString(),
                                  };
                                }).toList();
                                return ResultCard(
                                  title: item['title'],
                                  icon: item['icon'],
                                  iconColor: item['iconColor'],
                                  gradient: List<Color>.from(item['gradient']),
                                  items: List<Map<String, String>>.from(items),
                                );
                              },
                            );
                          }
                        },
                      ),
                      const Gap(12),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0068CC), Color(0xFF00CB9A)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.star_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const Gap(6),
                                Text(
                                  'Recommendations',
                                  style: AppTextStyles.font16BoldWhite,
                                ),
                              ],
                            ),
                            const Gap(8),
                            // Responsive topic chips layout
                            ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                // For mobile devices - vertical layout
                                if (sizingInformation.deviceScreenType ==
                                    DeviceScreenType.mobile) {
                                  return Column(
                                    children: [
                                      for (var s
                                          in result.careerSuggestions.take(4))
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: TopicChip(
                                            title: WordHelper.firstWord(s),
                                            label: WordHelper.shortPreview(s),
                                          ),
                                        ),
                                    ],
                                  );
                                }
                                // For desktop/tablet - wrap layout
                                else {
                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: result.careerSuggestions
                                        .take(4)
                                        .map((s) {
                                          return TopicChip(
                                            title: WordHelper.firstWord(s),
                                            label: WordHelper.shortPreview(s),
                                          );
                                        })
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const Gap(18),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            final bytes = ResultExporter.buildSimpleDocxBytes(
                              result,
                            );
                            ResultExporter.downloadDocxInBrowser(
                              bytes,
                              'assessment_report.docx',
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Report download started — check your browser\'s Downloads folder.',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0068CC),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Download Report',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      const Center(
                        child: Text(
                          'A detailed report with full results',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
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
}
