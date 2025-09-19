import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';

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
          child: CurvedContainer(
            width: Ui.width(context)-96,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleAnimWidget(
                  child: Image.asset(
                    Assets.good,
                    width: 80,
                  ),
                ),
                AppText.bold("Password Reset Successfully",fontSize: 20),
                AppText.thin("You have successfully reset your password.",color: AppColors.lightTextColor,alignment: TextAlign.center),
                
                Ui.boxHeight(32),
                AppButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.auth);
                  },
                  text: "Login",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
