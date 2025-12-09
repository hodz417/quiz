import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/core/utils/theme/app_theme.dart';
import 'package:mentor/feature/landing/ui/pages/meet_model.dart';
import 'package:mentor/feature/landing/ui/widgets/about_hero_section.dart';
import 'package:mentor/feature/landing/ui/widgets/team_carousel.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int selectedIndex = 0;

  final List<PersonsClass> team = const [
    PersonsClass(
      name: 'Mohanad Hossam',
      title: 'CEO Founder & Team Lead',
      bio:
          'Mohaned Hossam is the founder and CEO of Multiverse Mentor and the team lead behind the student-driven initiative. He is passionate about using AI to guide students through their learning journey, transforming confusion into a clear, personalized roadmap for skills and career choices. He oversees the project’s vision and strategy, leads business and innovation planning, explores growth opportunities, and builds partnerships that help the initiative reach more students.\n\n Mohaned also manages the project’s visual identity and content direction, ensuring that every design and message reflects the core values of Multiverse Mentor. His expertise includes: Leadership & team management Branding & visual identity Content strategy & communication Business development & partnerships Pitching & presenting Having faced similar challenges in learning and freelancing, Mohaned created Multiverse Mentor to offer students a smart AI companion that supports them—so they never have to navigate their educational journey alone.',
      image: 'assets/images/hero_image.png',
    ),
    PersonsClass(
      name: 'Nourhan Taha',
      title: 'Lead Product Designer',
      bio:
          'Nourhan translates user research into beautiful, accessible flows and owns the product design system across platforms.',
      image: 'assets/images/hero_image.png',
    ),
    PersonsClass(
      name: 'Abdullah Essam',
      title: 'Flutter Developer & Techincal Support',
      bio:
          "Abdullah Essam, a Flutter Developer with a strong passion for technology, innovation, and building meaningful digital experiences. I specialize in creating high-performance mobile applications with clean architecture, intuitive interfaces, and seamless user experiences. My work combines both technical depth and a solid understanding of modern design principles. I actively contribute as a Technical Contributor and Developer in the Multiverse Mentor project, where I help build intelligent, adaptive learning experiences powered by AI. \n\nMy role involves enhancing app functionality, improving UI/UX flows, and developing scalable solutions that support personalized education. Driven by curiosity and a constant desire for growth, I’m always exploring new tools, frameworks, and technologies. I aim to create practical, user-centered applications that solve real problems and push the boundaries of what mobile development can achieve.",
      image: 'assets/images/hero_image.png',
    ),
    PersonsClass(
      name: 'Mahmoud Hussein',
      title: 'Marketing Strategist',
      bio:
          'Mahmoud crafts the go-to-market strategy, partnering with sales and product to keep messaging sharp and data-driven.',
      image: 'assets/images/hero_image.png',
    ),
    PersonsClass(
      name: 'Awaab Mostafa',
      title: 'Back-End Developer & Media Buyer',
      bio:
          'Awab is a Back-End Developer with a strong focus on building reliable, efficient systems and ensuring smooth functionality across platforms. Alongside his technical expertise, he handles media buying for the team, managing targeted campaigns that help reach the right audiences effectively.\n\nHe also contributes to documentation and field research, collecting and integrating real-world data to support decision-making and improve project outcomes. Awab’s combination of technical skills and research-driven insight helps the team deliver accurate, informed, and high-impact solutions.',
      image: 'assets/images/hero_image.png',
    ),
    PersonsClass(
      name: 'Jhonathan Yousry',
      title: 'Graphic Designer & Media Documentation Lead',
      bio:
          'Jonathan Yosry is a Graphic Designer and Front-End Web Developer passionate about visual creativity, clean design, and building smooth, user-friendly digital experiences. He also leads media documentation within the team, handling photography, videography, and capturing key moments that reflect the team’s progress and impact.\n\nAs a contributor in MultiverseMentor, Jonathan plays a role in helping students grow through their learning journey. Having personally faced challenges while learning graphic design and web development, he understands the struggles many learners go through. This experience drives him to support others by simplifying concepts, offering clear guidance, and helping them develop their skills in a more effective and accessible way. Jonathan believes in empowering students to reach their potential and giving them the tools they need to start their careers with confidence.',
      image: 'assets/images/hero_image.png',
    ),
  ];

  PersonsClass get selectedPerson => team[selectedIndex];

  @override
  Widget build(BuildContext context) {
    final person = selectedPerson;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffecf5f7), Color(0xFFdfefee)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: MeetOurTeamAppbar(),
          ),

          body: SafeArea(
            top: false,
            child: Stack(
              children: [
            
                Column(
                  children: [
                    // const AboutHeader(),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1.2,
                      height: 0,
                    ),
                    Expanded(child: AboutHeroSection(person: person)),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TeamCarousel(
                    team: team,
                    selectedIndex: selectedIndex,
                    onSelect: (index) => setState(() => selectedIndex = index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MeetOurTeamAppbar extends StatelessWidget {
  const MeetOurTeamAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Container(
            height: 110.h,
            width: 110.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500)),
            child: SvgPicture.asset("assets/images/mentor_logo.svg"),
          ),
          Gap(50.w),
          Text("Meet Our Team", style: AppTextStyles.font14BlackBold),
          Gap(30.w),
          Text("Contact Us", style: AppTextStyles.font14BlackBold),
          const Spacer(),
          Row(
            children: [
              Text(
                'EN',
                style: AppTextStyles.font14BlackBold.copyWith(
                  color: AppColors.blueColor,
                ),
              ),
              Gap(5.w),
              Text('|', style: AppTextStyles.font14BlackBold),
              Gap(5.w),
              Text('AR', style: AppTextStyles.font14BlackBold),
            ],
          ),
        ],
      ),
    );
  }
}
