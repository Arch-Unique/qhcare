import 'package:qhcare/src/features/auth/repository/auth_repo.dart';
import 'package:qhcare/src/features/auth/views/forgot_password_page.dart';
import 'package:qhcare/src/features/auth/views/sent_success.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/src_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController {
  ///TEXT EDITING CONTROLLERS
  ///0 - LOGIN EMAIL
  ///1 - LOGIN PASSWORD
  ///2 - SIGNUP FIRSTNAME --- FULL NAME
  ///3 - SIGNUP LASTNAME
  ///4 - SIGNUP EMAIL
  ///5 - SIGNUP PASSWORD
  ///6 - SIGNUP CONFIRM PASSWORD
  ///7 - FP EMAIL
  List<TextEditingController> textControllers = List.generate(
    8,
    (index) => TextEditingController(),
  );

  Rx<AuthMode> currentAuthMode = AuthMode.login.obs;

  final authFormKey = GlobalKey<FormState>();
  final fpFormKey = GlobalKey<FormState>();
  final authRepo = Get.find<AuthRepo>();

  changeAuthMode() {
    currentAuthMode.value = currentAuthMode.value == AuthMode.register
        ? AuthMode.login
        : AuthMode.register;
  }

  onAuthPressed() async {
    if (authFormKey.currentState!.validate()) {
      try {
        if (currentAuthMode.value == AuthMode.login) {
          // await _onLogin();
        } else {
          // await _onRegister();
          Get.to(VerifyEmailScreen(false));
          return;
        }

        Get.offAllNamed(AppRoutes.dashboard);
      } catch (e) {
        Ui.showError(e.toString());
      }
      clearTextControllers();
    }
  }

  on3rdPartyAuthPressed(ThirdPartyTypes tpt) async {
    // try {
    // await authRepo.loginSocial(tpt);
    clearTextControllers();
    Get.offAllNamed(AppRoutes.dashboard);
    // } catch (e) {
    //   Ui.showError(e.toString());
    // }
  }

  onFPPressed() async {
    if (fpFormKey.currentState!.validate()) {
      try {
        // await _onForgotPassword();
        clearTextControllers();
        Get.off(SendSuccessScreen(spm: SuccessPagesMode.password));
      } catch (e) {
        Ui.showError(e.toString());
      }

      // Get.toNamed(AppRoutes.dashboard);
    }
  }

  _onLogin() async {
    await authRepo.login(
      textControllers[0].value.text,
      textControllers[1].value.text,
    );
  }

  _onRegister() async {
    await authRepo.register(
      textControllers[2].value.text,
      // textControllers[3].value.text,
      textControllers[4].value.text,
      textControllers[5].value.text,
    );
  }

  // _onForgotPassword() async {
  //   await authRepo.forgotPassword(textControllers[7].value.text);
  // }

  clearTextControllers() {
    UtilFunctions.clearTextEditingControllers(textControllers);
  }
}
