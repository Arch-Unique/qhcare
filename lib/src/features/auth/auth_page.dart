import 'package:qhcare/src/features/auth/controllers/auth_controller.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_textfield.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../global/ui/ui_barrel.dart';
import '../../src_barrel.dart';
import 'views/forgot_password_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final controller = Get.find<AuthController>();
  String oldPass = "";
  bool isDisabled = true;

  @override
  void initState() {
    // controller.textControllers[5].addListener(() {
    //   setState(() {
    //     oldPass = controller.textControllers[5].value.text;
    //   });
    // });

    super.initState();
  }

  void _updateButtonState() {
    setState(() {
      isDisabled = !controller.authFormKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(
              Assets.bg2,
              // fit: BoxFit.,
              fit: BoxFit.fitWidth,
              alignment: AlignmentDirectional.topCenter,
              
              height: Ui.height(context),
              width: Ui.width(context),
            ),
          ),
          SizedBox(
            height: Ui.height(context),
            child: SafeArea(
              child: Form(
                key: controller.authFormKey,
                onChanged: _updateButtonState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ui.align(
                    //   child: AppText.thin(controller.currentAuthMode.value.desc),
                    // ),
                   
                    

                    Ui.boxHeight(64),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
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
                              Ui.boxHeight(8),
                              AppText.bold(
                                controller.currentAuthMode.value.title,
                                fontSize: 24,
                                color: AppColors.textColor,
                              ),
                              Ui.boxHeight(8),
                              AppText.thin(
                                controller.currentAuthMode.value.desc,
                                fontSize: 14,
                                color: AppColors.lightTextColor,
                              ),
                              Ui.boxHeight(24),
                              if (controller.currentAuthMode.value ==
                                  AuthMode.login)
                                CustomTextField(
                                  "Enter email",
                                  controller.textControllers[0],
                                  varl: FPL.email,
                                  label: "Email",
                                ),
                              if (controller.currentAuthMode.value ==
                                  AuthMode.login)
                                CustomTextField.password(
                                  "* * * * * * * *",
                                  controller.textControllers[1],
                                  hbp: false,
                                ),
                              if (controller.currentAuthMode.value ==
                                  AuthMode.register)
                                CustomTextField(
                                  "Enter your name",
                                  controller.textControllers[2],
                                  label: "Name",
                                ),
                              // if (controller.currentAuthMode.value == AuthMode.register)
                              //   CustomTextField("Last Name", controller.textControllers[3]),
                              if (controller.currentAuthMode.value ==
                                  AuthMode.register)
                                CustomTextField(
                                  "Enter your email",
                                  controller.textControllers[4],
                                  varl: FPL.email,
                                  label: "Email",
                                ),
                              if (controller.currentAuthMode.value ==
                                  AuthMode.register)
                                CustomTextField.password(
                                  "Password",
                                  controller.textControllers[5],
                                ),
                              // if (controller.currentAuthMode.value == AuthMode.register)
                              //   CustomTextField.password(
                              //       "Confirm Password", controller.textControllers[6],
                              //       oldPass: oldPass),

                              if (controller.currentAuthMode.value ==
                                  AuthMode.login)
                                Ui.align(
                                  align: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(ForgotPasswordScreen());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AppText.bold(
                                        "Forgot Password?",
                                        fontSize: 14,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              Ui.boxHeight(
                                controller.currentAuthMode.value ==
                                        AuthMode.login
                                    ? 16
                                    : 8,
                              ),
                              AppButton(
                                onPressed: () async {
                                  await controller.onAuthPressed();
                                },
                                disabled: isDisabled,
                                text: controller.currentAuthMode.value ==
                                        AuthMode.register
                                    ? "Register"
                                    : "Continue",
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
                                      text: controller
                                          .currentAuthMode.value.after,
                                      style: TextStyle(
                                        color: AppColors.lightTextColor,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: controller.currentAuthMode.value
                                              .afterAction,
                                          style: TextStyle(
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Ui.boxHeight(24),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: AppColors.circleBorderColor,
                                    ),
                                  ),
                                  AppText.thin(
                                    "  Or  ",
                                    color: AppColors.darkTextColor,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: AppColors.circleBorderColor,
                                    ),
                                  ),
                                ],
                              ),
                              Ui.boxHeight(24),

                              CurvedContainer(
                                padding: EdgeInsets.all(12),
                                width: Ui.width(context) - 48,
                                color: AppColors.white,
                                onPressed: () async {
                                  await controller.on3rdPartyAuthPressed(
                                    ThirdPartyTypes.google,
                                  );
                                },
                                radius: 32,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Brand(
                                      ThirdPartyTypes.google.logo,
                                      size: 24,
                                    ),
                                    Ui.boxWidth(12),
                                    AppText.medium("Continue with google",
                                        color: AppColors.primaryColor),
                                  ],
                                ),
                              ),
                              Ui.boxHeight(12),
                              CurvedContainer(
                                padding: EdgeInsets.all(12),
                                width: Ui.width(context) - 48,
                                color: AppColors.white,
                                onPressed: () async {
                                  await controller.on3rdPartyAuthPressed(
                                    ThirdPartyTypes.google,
                                  );
                                },
                                radius: 32,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Brand(
                                      ThirdPartyTypes.apple.logo,
                                      size: 24,
                                    ),
                                    Ui.boxWidth(12),
                                    AppText.medium("Continue with google",
                                        color: AppColors.primaryColor),
                                  ],
                                ),
                              ),
                              Ui.boxHeight(12),
                              CurvedContainer(
                                padding: EdgeInsets.all(12),
                                width: Ui.width(context) - 48,
                                color: AppColors.white,
                                onPressed: () async {
                                  Get.offAllNamed(AppRoutes.dashboard);
                                },
                                radius: 32,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.waving_hand,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    Ui.boxWidth(12),
                                    AppText.medium("Login as a Guest",
                                        color: AppColors.primaryColor),
                                  ],
                                ),
                              ),

                              Ui.boxHeight(24),
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
    );
  }
}
