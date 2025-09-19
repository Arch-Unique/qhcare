import 'package:qhcare/src/features/onboarding/models/onboarding.dart';
import 'package:qhcare/src/src_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  final List<OnboardingPage> pages = [
    OnboardingPage(Assets.st1, "", Assets.ss1),
    OnboardingPage(Assets.st2, "", Assets.ss2),
    OnboardingPage(Assets.st3, "", Assets.ss3),
  ];

  nextPage() {
    if (currentPage.value != 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
      currentPage.value = currentPage.value + 1;
    } else {
      Get.toNamed(AppRoutes.auth);
    }
  }

  prevPage() {
    if (currentPage.value != 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
      currentPage.value = currentPage.value - 1;
    }
  }

  onChangePage(int index) {
    currentPage.value = index;
  }
}
