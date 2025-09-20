import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/features/dashboard/shared.dart';
import 'package:qhcare/src/features/onboarding/onboarding_page.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';

import '../../app/app_barrel.dart';
import '../../global/ui/ui_barrel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Expanded(
          child: SingleChildScrollView(
            child: Ui.padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   AppText.medium(
                    "Settings",
                    
                  ),
                  Ui.boxHeight(24),
                  AppText.medium(
                    "Account",
                    fontSize: 18
                  ),
                  SettingsItemWidget(
                    "Edit Profile",
                    "",
                    icon: Iconsax.user_outline,
                    onTap: () {},
                  ),
                   SettingsItemWidget(
                    "Language",
                    "",
                    icon: Iconsax.language_square_outline,
                    onTap: () {},
                  ),
                  
                  SettingsItemWidget(
                    "Notification",
                    "",
                    icon: Iconsax.notification_outline,
                    switchValue: true,
                    onSwitchChanged: (v) {},
                  ),
                  SettingsItemWidget(
                    "Security",
                    "",
                    icon: Iconsax.lock_outline,
                    onTap: () {},
                  ),
                  Ui.boxHeight(24),
                  AppText.medium(
                    "More",
                    color: AppColors.lightTextColor,
                    fontSize: 18
                  ),
                  Ui.boxHeight(12),
                  SettingsItemWidget(
                    "Help",
                    "",
                    icon: Icons.help_outline_rounded,
                    onTap: () {},
                  ),
                  SettingsItemWidget(
                    "Rate & Review",
                    "",
                    icon: Iconsax.star_outline,
                    onTap: () {},
                  ),
                  SettingsItemWidget(
                    "Privacy & Terms",
                    "",
                    icon: Iconsax.info_circle_outline,
                    onTap: () {
                      Get.to(AboutQHcareScreen());
                    },
                  ),
                  Ui.boxHeight(24),
                  Ui.align(
                    align: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Ui.showBottomSheet(
                          "Are you sure you want to logout ?",
                          "You will need to login again to access your account",
                          OnboardingScreen(),
                        );
                      },
                      child: AppText.bold("Log Out",fontSize: 12,color:AppColors.red)),
                  ),
                  Ui.boxHeight(24),
                  
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AboutQHcareScreen extends StatelessWidget {
  const AboutQHcareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinglePageScaffold(
      title: "About QHcare+",
      child: Column(
        children: [
          AppDivider(),
          Expanded(
            child: Ui.padding(
              child: AppText.thin('''
QHcare+ is an AI-powered app that helps you discover the perfect Yoruba proverb for any situation.
                      
Whether you're seeking wisdom, learning through play, or just curious about Yoruba culture — QHcare+ lets you ṣàlàyé ìṣèlẹ̀, ká lè rí òwe tó bá a mu (describe a situation to find the right proverb).
                      
More than just proverbs, it's a celebration of language, heritage, and timeless wisdom.
                      '''),
            ),
          ),
        ],
      ),
    );
  }
}
