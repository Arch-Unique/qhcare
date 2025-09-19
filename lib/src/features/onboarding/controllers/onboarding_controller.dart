import 'package:qhcare/src/features/onboarding/models/onboarding.dart';
import 'package:qhcare/src/src_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  final List<OnboardingPage> pages = [
    OnboardingPage("Smarter Triage in Seconds", "Describe your symptoms and let our AI guide you to the right department -  quickly, safely, and accurately", Assets.ss1,"Get Started","Skip"),
    OnboardingPage("No More Endless Waiting", "Describe your symptoms and let our AI guide you to the right department -  quickly, safely, and accurately", Assets.ss1,"Continue","Skip"),
    OnboardingPage("Care that Stays with You", "Describe your symptoms and let our AI guide you to the right department -  quickly, safely, and accurately", Assets.ss1,"Register","Login"),

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
