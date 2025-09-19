import 'package:qhcare/src/features/auth/controllers/auth_controller.dart';
import 'package:qhcare/src/features/auth/views/sent_success.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/ui/ui_barrel.dart';
import '../../../src_barrel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordScreen> {
  final controller = Get.find<AuthController>();
  bool isDisabled = true;

  void _updateButtonState() {
    setState(() {
      isDisabled = !controller.fpFormKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Image.asset(
            Assets.bg2,
            fit: BoxFit.cover,
            height: Ui.height(context),
            width: Ui.width(context),
          ),
          SizedBox(
            height: Ui.height(context),
            child: SafeArea(
              child: Column(
                children: [
                  // backAppBar(
                  //   title: "Forgot Password",
                  //   bgColor: AppColors.transparent,
                  // ),
                  Ui.boxHeight(80),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        color: AppColors.white,
                      ),
                      child: Form(
                        key: controller.fpFormKey,
                        onChanged: _updateButtonState,
                        child: Column(
                          children: [
                            Ui.boxHeight(8),
                              AppText.bold(
                                "Forgot Password",
                                fontSize: 24,
                                color: AppColors.textColor,
                              ),
                              
                            Ui.boxHeight(8),
                            AppText.thin(
                              "Enter your email address to proceed.",
                            ),
                            Ui.boxHeight(24),
                            CustomTextField(
                              "Enter email address",
                              label: "Email",
                              controller.textControllers[7],
                              varl: FPL.email,
                            ),
                            Ui.boxHeight(24),
                            AppButton(
                              onPressed: () async {
                                await controller.onFPPressed();
                              },
                              disabled: isDisabled,
                              text: "Proceed",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen(this.isHome, {super.key});
  final bool isHome;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final controller = Get.find<AuthController>();
  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Image.asset(
            Assets.bg2,
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
                  // Ui.align(
                  //   child: AppText.thin(controller.currentAuthMode.value.desc),
                  // ),
                  backAppBar(
                    title: "Verification",
                    bgColor: AppColors.transparent,
                  ),
                  Ui.boxHeight(24),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        color: AppColors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            UniversalImage(Assets.mail, width: 88, height: 88),
                            Ui.boxHeight(24),
                            AppText.bold(
                              "Please verify your email",
                              fontSize: 18,
                            ),
                            Ui.boxHeight(24),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      "Enter the 6 digit code we sent by email to ",
                                  style: TextStyle(
                                    color: AppColors.lightTextColor,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: controller.textControllers[4].text,
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Ui.boxHeight(24),
                            Ui.boxHeight(24),
                            AppButton(
                              onPressed: () async {
                                if (widget.isHome) {
                                  Get.offAllNamed(AppRoutes.dashboard);
                                } else {
                                  Get.to(SendSuccessScreen());
                                }
                              },
                              disabled: isDisabled,
                              text: "Verify",
                            ),
                            Ui.boxHeight(16),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  controller.changeAuthMode();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    text: "Didn't receive the code? ",
                                    style: TextStyle(
                                      color: AppColors.lightTextColor,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Resend",
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
