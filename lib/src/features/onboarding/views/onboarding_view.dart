import 'package:qhcare/src/features/onboarding/models/onboarding.dart';
import 'package:flutter/material.dart';

import '../../../global/ui/ui_barrel.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView(this._onboardingPage, {super.key});
  final OnboardingPage _onboardingPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UniversalImage(_onboardingPage.title, width: Ui.width(context) - 48),
        Ui.boxHeight(36),
        UniversalImage(_onboardingPage.image, width: Ui.width(context) - 48),
        Ui.boxHeight(16),
      ],
    );
  }
}
