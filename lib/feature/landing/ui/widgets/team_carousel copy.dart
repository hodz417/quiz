import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/feature/landing/ui/pages/meet_model.dart';


class TeamCarousel extends StatelessWidget {
  final List<PersonsClass> team;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const TeamCarousel({
    super.key,
    required this.team,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.25), width: 1),
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(team.length, (index) {
                final member = team[index];
                final isSelected = index == selectedIndex;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      if (selectedIndex != index) {
                        onSelect(index);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOut,
                          height: isSelected ? 96 : 76,
                          width: isSelected ? 96 : 76,
                          margin: EdgeInsets.only(bottom: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Colors.white.withValues(alpha: 0.6),
                              width: isSelected ? 3 : 1.2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(member.image, fit: BoxFit.cover),
                          ),
                        ),
                        Text(
                          member.name,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font14BlackBold.copyWith(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 160.w,
                          child: Text(
                            member.title,
                            // style: AppTextStyles.fontGrey16Bold.copyWith(
                            //   fontSize: 12,
                            //   color: Colors.black54,
                            // ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
