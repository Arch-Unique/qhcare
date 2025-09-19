import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/ui/ui_barrel.dart';
import '../../../src_barrel.dart';

class SendSuccessScreen extends StatelessWidget {
  const SendSuccessScreen({this.spm = SuccessPagesMode.password, super.key});
  final SuccessPagesMode spm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Ui.padding(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleAnimWidget(
                child: Image.asset(
                  Assets.good,
                  width: Ui.width(context) - 48,
                ),
              ),
              AppText.medium("Akẹ́kọ̀ọ́ tuntun, káàbọ̀! 🎉",color: AppColors.white,fontSize: 18),
              AppText.thin("Your journey into the world of Yoruba wisdom has begun.",color: AppColors.white,alignment: TextAlign.center),
              
              Ui.boxHeight(56),
              AppButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashboard);
                },
                color: AppColors.white,
                text: "Let's Start",
              )
            ],
          ),
        ),
      ),
    );
  }
}
