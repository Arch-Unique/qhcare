import 'package:qhcare/src/features/dashboard/cta_page.dart';
import 'package:qhcare/src/features/dashboard/game_page.dart';
import 'package:qhcare/src/features/dashboard/home_page.dart';
import 'package:qhcare/src/features/dashboard/learning_page.dart';
import 'package:qhcare/src/features/dashboard/profile.dart';
import 'package:qhcare/src/features/dashboard/shared.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src_barrel.dart';
import 'controllers/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final screens = [
    AppHomePage(),
    GamePage(),
    CTAPage(),
    LearningPage(),
    ProfilePage(),
  ];
  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: Color(0xFFF5F5F5),
      floatingActionButton: InkWell(
        onTap: () {
          controller.currentIndex.value = 2;
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFB0BFCB),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: UniversalImage(Assets.logo, width: 32, height: 32),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Image.asset(
            Assets.bg2,
            fit: BoxFit.cover,
            height: Ui.height(context),
            width: Ui.width(context),
          ),
          FadeAnimWidget(
            d: Duration(milliseconds: 300),
            child: SizedBox(
              height: Ui.height(context),
              child: Obx(() {
                return screens[controller.currentIndex.value];
              }),
            ),
          ),
        ],
      ),
    );
  }
}
