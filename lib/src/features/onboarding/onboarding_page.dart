import 'package:icons_plus/icons_plus.dart';
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

            Positioned(
              top: 0,
              height: (Ui.height(context) / 2) + 32,
                width: Ui.width(context),
              child: PageView.builder(
                    itemCount: controller.pages.length,
                    pageSnapping: true,
                    controller: controller.pageController,
                    onPageChanged: controller.onChangePage,
                    itemBuilder: (_, i) {
                      return Image.asset(
                controller.pages[i].image,
                fit: BoxFit.cover,
                height: (Ui.height(context) / 2) + 32,
                width: Ui.width(context),
              );
                    },
                  ),
            ),
            Positioned(
              top: 24,
              left: 24,
              child: Obx(
                 () {
                  if(controller.currentPage.value == 0){
                    return SizedBox();
                  }
                  return SafeArea(child: GestureDetector(
                    onTap: (){
                      controller.prevPage();
                    },
                    child: CircleAvatar(
                    radius: 20,
                    child: AppIcon(Icons.chevron_left),
                    backgroundColor: AppColors.lightTextColor.withOpacity(0.4),
                                ),
                  ));
                }
              )),
            Positioned(
              bottom: 0,
              height: (Ui.height(context) / 2),
                child: Obx(
                   () {
                    return OnboardingView(controller.pages[controller.currentPage.value],
                        indicator: SizedBox(
                          width: 114,
                          child: PageIndicator(
                            controller.pageController,
                            dotCount: controller.pages.length,
                          ),
                        ),
                        ctas: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppButton(
                              onPressed: () {
                                controller.nextPage();
                              },
                              text: controller.pages[controller.currentPage.value].btnAText,
                            ),
                            Ui.boxHeight(8),
                            AppButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.auth);
                              },
                              borderColor: AppColors.primaryColor,
                              color: AppColors.accentColor.withOpacity(0.05),
                              text: controller.pages[controller.currentPage.value].btnBText,
                            )
                          ],
                        ));
                  }
                )),
            //  Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Ui.boxHeight(12),
            //     Ui.padding(
            //       child: PageIndicator(
            //         controller.pageController,
            //         dotCount: controller.pages.length,
            //       ),
            //     ),
            //     Expanded(
            //       child: PageView.builder(
            //         itemCount: controller.pages.length,
            //         pageSnapping: true,
            //         controller: controller.pageController,
            //         onPageChanged: controller.onChangePage,
            //         itemBuilder: (_, i) {
            //           return Center(
            //             child: OnboardingView(controller.pages[i]),
            //           );
            //         },
            //       ),
            //     ),
            //     Ui.padding(
            //       child: Obx(() {
            //         if (controller.currentPage.value == 2) {
            //           return AppButton(
            //             onPressed: () {
            //               controller.nextPage();
            //             },
            //             text: "Get Started",
            //           );
            //         }
            //         return Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             SizedBox(
            //               width: Ui.width(context) * 0.3,
            //               child: AppButton(
            //                 onPressed: () {
            //                   controller.prevPage();
            //                 },
            //                 text: "Prev",
            //               ),
            //             ),
            //             Spacer(),
            //             SizedBox(
            //               width: Ui.width(context) * 0.3,
            //               child: AppButton(
            //                 onPressed: () {
            //                   controller.nextPage();
            //                 },
            //                 text: "Next",
            //               ),
            //             ),
            //           ],
            //         );
            //       }),
            //     ),
            //   ],
            // ),
         
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
