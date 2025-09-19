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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SizedBox(
              height: Ui.height(context),
              child: Obx(() {
                return screens[controller.currentIndex.value];
              }),
            ),
    );
  }
}
