import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qhcare/src/features/dashboard/controllers/dashboard_controller.dart';
import 'package:qhcare/src/features/dashboard/shared.dart';
import 'package:qhcare/src/global/model/user.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_textfield.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../global/ui/ui_barrel.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  final controller = Get.find<DashboardController>();

  @override
  void initState() {
    controller.getDailyProverb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                Ui.boxHeight(24),
                CustomTextField.search(
                  "Search",
                  TextEditingController(),
                  () {},
                ),
                Ui.boxHeight(24),
                MatchScenarioWidget(),
                Ui.boxHeight(24),
              ],
            ),
          ),
          QuizInfoWidget(),
          CurvedContainer(
            color: Color(0xFF007B9D),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            radius: 8,
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  insetPadding: EdgeInsets.all(24),
                  contentPadding: EdgeInsets.all(0),
                  backgroundColor: AppColors.white,
                  content: Obx(() {
                    return ProverbWidget(controller.currentProverb.value);
                  }),
                ),
              );
            },
            child: Row(
              children: [
                UniversalImage(Assets.guard, width: 56, height: 56),
                Ui.boxWidth(4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.bold(
                        "Daily Proverb",
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                      Ui.boxHeight(4),
                      Obx(() {
                        return AppText.thin(
                          controller.currentProverb.value.proverb,
                          color: AppColors.white,
                          maxlines: 3,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
