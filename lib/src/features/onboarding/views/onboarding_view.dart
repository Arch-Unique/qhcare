import 'package:qhcare/src/features/onboarding/models/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../../global/ui/ui_barrel.dart';
import '../../../global/ui/widgets/others/containers.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView(this._onboardingPage, {required this.indicator,required this.ctas,super.key});
  final OnboardingPage _onboardingPage;
  final Widget indicator,ctas;

  @override
  Widget build(BuildContext context) {
    return CurvedContainer(
      height: Ui.height(context)/2,
      width: Ui.width(context),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          Ui.boxHeight(48),
          AppText.bold(_onboardingPage.title,fontSize: 20,alignment: TextAlign.center),
          AppText.thin(_onboardingPage.desc,fontSize: 14,color: AppColors.lightTextColor,alignment: TextAlign.center),
          const Spacer(),
          ctas,
          const Spacer(),
        ],
      ),
    );
  }
}
