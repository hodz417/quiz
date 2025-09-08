import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart'; // Assuming AppColors is here
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart'; // Import the model
import 'package:quiz/feature/result/data/result_exporter.dart'; // Import ResultExporter
import 'package:quiz/feature/result/ui/widgets/result_card.dart'; // Import ResultCard
import 'package:quiz/feature/result/ui/widgets/topic_chip.dart'; // Import TopicChip
import 'package:responsive_builder/responsive_builder.dart'; // Import ResponsiveBuilder

class ResultPageWeb extends StatelessWidget {
  final AnalysisResult result; // Expect the updated AnalysisResult object

  const ResultPageWeb({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final containerWidth = mediaQuery.size.width > 900
        ? mediaQuery.size.width * 0.55
        : mediaQuery.size.width * 0.95;

    // Prepare data for ResultCards using new UI-specific fields
    final resultsData = <Map<String, dynamic>>[
      {
        'title': 'Personality',
        'icon': Icons.psychology,
        'iconColor':
            AppColors.blueColor, // Ensure AppColors is defined/imported
        'gradient': [const Color(0xFFE7F3FF), Colors.white],
        'items': [
          {
            'value': result.personalityType, // Use personalityType
            'label': '',
          },
          {
            'value':
                result.personalityExplanation, // Use personalityExplanation
            'label': '',
          },
        ],
      },
      {
        'title': 'Learning Style',
        'icon': Icons.school,
        'iconColor': const Color(0xFF16A34A),
        'gradient': [const Color(0xFFDCFCE7), Colors.white],
        'items': [
          {
            'value':
                'Visual: ${result.learningStylePercentages['Visual'] ?? 0}%',
            'label': '',
          },
          {
            'value':
                'Verbal: ${result.learningStylePercentages['Verbal'] ?? 0}%',
            'label': '',
          },
          {
            'value':
                'Kinesthetic: ${result.learningStylePercentages['Kinesthetic'] ?? 0}%',
            'label': '',
          },
        ],
      },
      {
        'title': 'Goals',
        'icon': Icons.flag,
        'iconColor': Colors.black,
        'gradient': [Colors.white, Colors.white],
        'items': result
            .inferredGoals // Use inferredGoals
            .map(
              (g) => {
                'value': WordHelper.shortPreview(
                  g,
                  maxWords: 4,
                ), // Short preview for UI
                'label': '',
              },
            )
            .toList(),
      },
      {
        'title': 'Strengths',
        'icon': Icons.star, // Changed icon
        'iconColor': Colors.amber,
        'gradient': [Colors.white, Colors.white],
        'items': result
            .keyStrengths // Use keyStrengths
            .map(
              (s) => {
                'value': WordHelper.shortPreview(
                  s,
                  maxWords: 4,
                ), // Short preview for UI
                'label': '',
              },
            )
            .toList(),
      },
    ];

    return Scaffold(
      backgroundColor:
          AppColors.kPrimaryBg, // Ensure AppColors is defined/imported
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
                  textDirection: TextDirection.ltr, // Adjust if needed
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
                          result
                              .uiSummary, // Use uiSummary for the main summary
                          style: AppTextStyles.font17Grey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(14),
                      // Responsive card layout using the prepared data
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          // For mobile devices - vertical layout
                          if (sizingInformation.deviceScreenType ==
                              DeviceScreenType.mobile) {
                            return Column(
                              children: resultsData.map((item) {
                                return ResultCard(
                                  title: item['title'],
                                  icon: item['icon'],
                                  iconColor: item['iconColor'],
                                  gradient: List<Color>.from(item['gradient']),
                                  items: List<Map<String, String>>.from(
                                    item['items'],
                                  ),
                                );
                              }).toList(),
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
                                    childAspectRatio: 3.2, // Adjust if needed
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                              itemBuilder: (context, idx) {
                                final item = resultsData[idx];
                                return ResultCard(
                                  title: item['title'],
                                  icon: item['icon'],
                                  iconColor: item['iconColor'],
                                  gradient: List<Color>.from(item['gradient']),
                                  items: List<Map<String, String>>.from(
                                    item['items'],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      const Gap(12),
                      // Freelance Recommendations Section - Use freelanceJobs['uiList']
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
                              children: [
                                const Icon(
                                  Icons.work_outline, // Changed icon to work
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const Gap(6),

                                Text(
                                  'Freelance Opportunities', // Changed title
                                  style: AppTextStyles.font16BoldWhite,
                                ),
                              ],
                            ),
                            const Gap(8),
                            // Responsive topic chips layout for freelance jobs
                            ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                // For mobile devices - vertical layout
                                if (sizingInformation.deviceScreenType ==
                                    DeviceScreenType.mobile) {
                                  return Column(
                                    children: (result.freelanceJobs['uiList'] ?? [])
                                        .map((job) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8.0,
                                            ),
                                            child: TopicChip(
                                              title: WordHelper.firstWord(
                                                job,
                                              ), // First word for chip title
                                              label: WordHelper.shortPreview(
                                                job,
                                                maxWords: 3,
                                              ), // Short preview for chip label
                                            ),
                                          );
                                        })
                                        .toList(),
                                  );
                                }
                                // For desktop/tablet - wrap layout
                                else {
                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        (result.freelanceJobs['uiList'] ?? [])
                                            .map((job) {
                                              return TopicChip(
                                                title: WordHelper.firstWord(
                                                  job,
                                                ), // First word for chip title
                                                label: WordHelper.shortPreview(
                                                  job,
                                                  maxWords: 3,
                                                ), // Short preview for chip label
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
                            // Use the potentially updated exporter for detailed report
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
