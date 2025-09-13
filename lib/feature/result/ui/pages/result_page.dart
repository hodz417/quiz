import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart'; 
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:quiz/feature/result/data/result_exporter.dart';
import 'package:quiz/feature/result/ui/widgets/result_card.dart';
import 'package:quiz/feature/result/ui/widgets/topic_chip.dart'; 
import 'package:responsive_builder/responsive_builder.dart';

class ResultPageWeb extends StatelessWidget {
  final AnalysisResult result; 
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
        'title': context.l10n.personality,
        'icon': Icons.psychology,
        'iconColor': AppColors.blueColor,
        'gradient': [const Color(0xFFE7F3FF), Colors.white],
        'items': [
          {'value': result.personalityType, 'label': ''},
          {'value': result.personalityExplanation, 'label': ''},
        ],
      },
      {
        'title': context.l10n.learningStyle,
        'icon': Icons.school,
        'iconColor': const Color(0xFF16A34A),
        'gradient': [const Color(0xFFDCFCE7), Colors.white],
        'items': [
          {
            'value':
                '${context.l10n.visual}: ${result.learningStylePercentages['Visual'] ?? 0}%',
            'label': '',
          },
          {
            'value':
                '${context.l10n.verbal}: ${result.learningStylePercentages['Verbal'] ?? 0}%',
            'label': '',
          },
          {
            'value':
                '${context.l10n.kinesthetic}: ${result.learningStylePercentages['Kinesthetic'] ?? 0}%',
            'label': '',
          },
        ],
      },
      {
        'title': context.l10n.goals,
        'icon': Icons.flag,
        'iconColor': Colors.black,
        'gradient': [Colors.white, Colors.white],
        'items': result.inferredGoals
            .map((g) => {'value': g.toString(), 'label': ''})
            .toList(),
      },
      {
        'title': context.l10n.strengths,
        'icon': Icons.star,
        'iconColor': Colors.amber,
        'gradient': [Colors.white, Colors.white],
        'items': result.keyStrengths
            .map((s) => {'value': s.toString(), 'label': ''})
            .toList(),
      },
    ];

    final uiList = (result.freelanceJobs['uiList'] ?? [])
        .map((e) => e.toString())
        .toList();

    return Scaffold(
      backgroundColor: AppColors.kPrimaryBg,
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          final isMobile =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile;
          return SafeArea(
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
                              context.l10n.congratulations,
                              style: isMobile
                                  ? AppTextStyles.font56BoldBlack
                                  : AppTextStyles.font30BoldBlack,
                            ),
                          ),
                          const Gap(8),
                          Center(
                            child: Text(
                              result.uiSummary,
                              style: isMobile
                                  ? AppTextStyles.font35Grey
                                  : AppTextStyles.font17Grey,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(14),
                          // Cards: column on mobile, grid on larger screens
                          if (isMobile)
                            Column(
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
                            )
                          else
                            GridView.builder(
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
                                      Icons.work_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const Gap(6),
                                    Text(
                                      context.l10n.freelanceOpportunities,
                                      style: isMobile
                                          ? AppTextStyles.font45BoldBlack
                                              .copyWith(color: Colors.white)
                                          : AppTextStyles.font16BoldWhite,
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                if (isMobile)
                                  Column(
                                    children: uiList.map((job) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: TopicChip(title: job, label: ''),
                                      );
                                    }).toList(),
                                  )
                                else
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: uiList.map((job) {
                                      return TopicChip(title: job, label: '');
                                    }).toList(),
                                  ),
                              ],
                            ),
                          ),
                          const Gap(12),
                          // Practical Steps Section
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
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
                                      Icons.lightbulb_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const Gap(6),
                                    Text(
                                  context.    l10n.practicalNextSteps,
                                      style: isMobile
                                          ? AppTextStyles.font45BoldBlack
                                              .copyWith(color: Colors.white)
                                          : AppTextStyles.font16BoldWhite,
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                if (isMobile)
                                  Column(
                                    children: result.practicalSteps.map((step) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: TopicChip(title: step, label: ''),
                                      );
                                    }).toList(),
                                  )
                                else
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: result.practicalSteps.map((step) {
                                      return TopicChip(title: step, label: '');
                                    }).toList(),
                                  ),
                              ],
                            ),
                          ),
                          const Gap(18),
                          // Inspirational Quote
                          Center(
                            child: Text(
                              '"${result.inspirationalQuote}"',
                              style: isMobile
                                  ? AppTextStyles.font35Grey.copyWith(fontStyle: FontStyle.italic)
                                  : AppTextStyles.font17Grey.copyWith(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(12),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                final bytes =
                                    ResultExporter.buildSimpleDocxBytes(result);
                                ResultExporter.downloadDocxInBrowser(
                                  bytes,
                                  'assessment_report.docx',
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.l10n.reportDownloadStarted,
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
                              child: Text(
                                context.l10n.downloadReport,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Center(
                            child: Text(
                          context.    l10n.detailedReportWithFullResults,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}