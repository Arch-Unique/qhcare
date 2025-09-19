import 'package:qhcare/src/features/onboarding/controllers/onboarding_controller.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src_barrel.dart';
import 'views/onboarding_view.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Ui.height(context),
        child: Stack(
          children: [
            Image.asset(
              Assets.bg1,
              fit: BoxFit.cover,
              height: Ui.height(context),
              width: Ui.width(context),
            ),
            SizedBox(
              height: Ui.height(context),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ui.boxHeight(12),
                    Ui.padding(
                      child: PageIndicator(
                        controller.pageController,
                        dotCount: controller.pages.length,
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: controller.pages.length,
                        pageSnapping: true,

                        controller: controller.pageController,
                        onPageChanged: controller.onChangePage,
                        itemBuilder: (_, i) {
                          return Center(
                            child: OnboardingView(controller.pages[i]),
                          );
                        },
                      ),
                    ),
                    Ui.padding(
                      child: Obx(() {
                        if (controller.currentPage.value == 2) {
                          return AppButton(
                            onPressed: () {
                              controller.nextPage();
                            },
                            text: "Get Started",
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Ui.width(context) * 0.3,
                              child: AppButton(
                                onPressed: () {
                                  controller.prevPage();
                                },
                                text: "Prev",
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: Ui.width(context) * 0.3,
                              child: AppButton(
                                onPressed: () {
                                  controller.nextPage();
                                },
                                text: "Next",
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // child: Ui.padding(
        //   child: Column(
        //     children: [
        //       const Spacer(),
        //       const SSLogoWidget(),
        //
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
