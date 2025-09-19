import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_dropdown.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_textfield.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';
import 'package:qhcare/src/src_barrel.dart';
import 'package:share_plus/share_plus.dart';

import '../../global/model/user.dart';
import 'controllers/dashboard_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final controller = Get.find<DashboardController>();

  void _onItemTapped(int indexi) {
    int index = indexi;
    if (index == 2) {
      return;
    }

    setState(() {
      _selectedIndex = index;
      controller.currentIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: Offset(0, -4),
          ),
          BoxShadow(
            color: Color(0xFF101010).withOpacity(0.06),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.lightTextColor,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home_2_outline),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.d_square_outline),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Empty space for FAB
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.book_outline),
              label: 'Learning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_2user_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader(
      {this.isHeader = true,
      this.isUpcoming = false,
      this.isNotUpcoming = false,
      super.key});
  final bool isHeader, isNotUpcoming, isUpcoming;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          UserProfilePic(),
          Ui.boxWidth(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.bold(
                "Hi, Temitope",
                color: isHeader ? AppColors.textColor : AppColors.white,
                fontSize: 16,
              ),
              Ui.boxHeight(4),
              AppText.medium(
                isHeader ? "How is your health?" : "Cardiologist",
                color: isHeader ? AppColors.lightTextColor : AppColors.white,
                fontSize: 12,
              ),
            ],
          ),
          Spacer(),
          if (isHeader)
            CurvedContainer(
              radius: 32,
              width: 48,
              color: AppColors.lightTextColor.withOpacity(0.5),
              height: 48,
              child: Center(
                child: Icon(
                  Iconsax.notification_bold,
                  color: AppColors.textColor,
                  size: 20,
                ),
              ),
              onPressed: () {
                // Handle notification button press
              },
            ),
          if (isUpcoming)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.white,
                  child: AppIcon(
                    Iconsax.video_outline,
                    size: 16,
                  ),
                ),
                Ui.boxWidth(8),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.white,
                  child: AppIcon(
                    Iconsax.call_outline,
                    size: 16,
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class TitleSeeAll extends StatelessWidget {
  const TitleSeeAll(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bold(title),
        AppText.bold("See All", fontSize: 14, color: AppColors.primaryColor)
      ],
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon(this.icon,{this.vb,super.key});
  final dynamic icon;
  final VoidCallback? vb;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: vb,
      child: CircleAvatar(
        backgroundColor: AppColors.lightTextColor
        .withOpacity(0.3),
        radius: 24,
        child: AppIcon(icon),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.title,{this.action,super.key});
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleIcon(Icons.chevron_left,vb: (){
          Get.back();
        }),
        AppText.bold(title),
        if(action != null)
        action!
      ],
    );
  }
}

class MatchScenarioWidget extends StatelessWidget {
  const MatchScenarioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController scenarioTec = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          "Enter a scenario",
          scenarioTec,
          bcol: AppColors.white,
          varl: FPL.multi,
          hasBottomPadding: false,
          label: "Match a Scenario to a Proverb",
        ),
        Ui.boxHeight(8),
        AppText.thin("This is a hint text to help user.", fontSize: 12),
        Ui.boxHeight(24),
        AppButton(
          onPressed: () async {
            final proverb = await Get.find<DashboardController>().matchScenario(
              scenarioTec.text,
            );
            if (proverb != null) {
              Get.dialog(
                AlertDialog(
                  insetPadding: EdgeInsets.all(24),
                  contentPadding: EdgeInsets.all(0),
                  backgroundColor: AppColors.white,
                  content: ProverbWidget(proverb),
                ),
              );
            }
          },
          text: "Find Proverb",
        ),
      ],
    );
  }
}

class QuizInfoWidget extends StatelessWidget {
  const QuizInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> tecs = List.generate(
      3,
      (i) => TextEditingController(),
    );
    tecs[1].text = 5.toString();
    tecs[2].text = "Mixture";
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.bold("Answer Quiz", color: Color(0xFF007B9D)),
          Ui.boxHeight(8),
          CustomTextField("Enter your name", tecs[0], label: "Name"),
          CustomDropdown.days(
            hint: "Select number of questions",
            selectedValue: 5,
            onChanged: (value) {
              tecs[1].text = value.toString();
            },
          ),
          CustomDropdown.city(
            hint: "Select Quiz Type",
            selectedValue: "Mixture",
            onChanged: (value) {
              tecs[2].text = value.toString();
            },
            cities: ["Mixture", "Scenario To Proverb", "Proverb To Scenario"],
          ),
          AppButton(
            onPressed: () async {
              final controller = Get.find<DashboardController>();
              await controller.getCurrentQuiz(
                tecs[0].text,
                tecs[2].text,
                int.tryParse(tecs[1].text) ?? 0,
              );
              if (controller.currentQuiz.value.quizzes.isNotEmpty) {
                Get.dialog(
                  AlertDialog(
                    insetPadding: EdgeInsets.all(12),
                    contentPadding: EdgeInsets.all(0),
                    backgroundColor: AppColors.white,
                    content: QuizWidget(controller.currentQuiz.value),
                  ),
                );
              }
            },
            text: "Start Quiz",
          ),
        ],
      ),
    );
  }
}

class TitleValueWidget extends StatelessWidget {
  const TitleValueWidget(this.title, this.value, {super.key});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        AppText.bold("$title:", color: AppColors.accentColor, fontSize: 18),
        Ui.boxHeight(4),

        //if value contains HTML string
        if (value.contains("<") && value.contains(">")) Html(data: value),

        //if value is plain text
        if (value.isNotEmpty && !value.contains("<") && !value.contains(">"))
          AppText.thin(value, color: AppColors.lightTextColor),
        Ui.boxHeight(12),
      ],
    );
  }
}

class QuizTitleValueWidget extends StatelessWidget {
  const QuizTitleValueWidget(this.title, this.value, {super.key});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$title:",
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: AppColors.lightTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
        ),
        // AppText.bold("$title:", color: AppColors.accentColor, fontSize: 14),
        // Ui.boxWidth(4),
        // Expanded(
        //     child: AppText.thin(value,
        //         color: AppColors.lightTextColor, fontSize: 14)),
      ],
    );
  }
}

class QuizSummarywidget extends StatelessWidget {
  const QuizSummarywidget(this.qr, {super.key});
  final QuizResults qr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ui.boxHeight(16),
            AppText.bold(
              "QUIZ RESULTS",
              fontSize: 20,
              color: AppColors.textColor,
            ),
            Ui.boxHeight(24),
            QuizTitleValueWidget(
              "Score",
              "${qr.score}/${qr.total} (${qr.percentage}%)",
            ),
            Ui.boxHeight(4),
            QuizTitleValueWidget("Grade", qr.grade),
            Ui.boxHeight(16),
            Ui.align(
              child: AppText.bold(
                "BREAKDOWN BY TYPE",
                color: AppColors.accentColor,
                fontSize: 18,
              ),
            ),
            Ui.boxHeight(4),
            QuizTitleValueWidget(
              "PROVERB TO SCENARIO",
              "${qr.breakdown.proverbToScenario.correct}/${qr.breakdown.proverbToScenario.total} (${qr.breakdown.proverbToScenario.percentage}%)",
            ),
            Ui.boxHeight(4),
            QuizTitleValueWidget(
              "SCENARIO TO PROVERB",
              "${qr.breakdown.scenarioToProverb.correct}/${qr.breakdown.scenarioToProverb.total} (${qr.breakdown.scenarioToProverb.percentage}%)",
            ),
            Ui.boxHeight(16),
            Ui.align(
              child: AppText.bold(
                "QUESTION BY QUESTION RESULTS",
                color: AppColors.accentColor,
                fontSize: 18,
              ),
            ),
            Ui.boxHeight(4),
            ...List.generate(qr.results.length, (i) {
              final option = qr.results[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuizTitleValueWidget(
                    "Question ${i + 1} (${option.type.toUpperCase().replaceAll("_", " ")})",
                    option.correct ? "Correct" : "Incorrect",
                  ),
                  Ui.boxHeight(4),
                  QuizTitleValueWidget("Selected", option.selected),
                  Ui.boxHeight(4),
                  QuizTitleValueWidget("Correct Answer", option.correctAnswer),
                  Ui.boxHeight(4),
                  QuizTitleValueWidget("Feedback", option.message),
                  Ui.boxHeight(16),
                ],
              );
            }),
            Ui.boxHeight(16),
            AppButton(
              onPressed: () async {
                final params = ShareParams(
                  files: [
                    XFile.fromData(
                      utf8.encode(qr.csvContent),
                      mimeType: 'text/plain',
                    ),
                  ],
                  fileNameOverrides: ['myresult.txt'],
                );

                SharePlus.instance.share(params);
              },
              text: "Share Results",
            ),
            Ui.boxHeight(8),
            AppButton(
              onPressed: () {
                Get.back();
              },
              text: "Back to Home",
              color: AppColors.borderColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ProverbWidget extends StatelessWidget {
  const ProverbWidget(this.proverb, {super.key});
  final Proverb proverb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UniversalImage(
              proverb.scenario.isEmpty ? Assets.info : Assets.quiz,
              width: 88,
            ),
            Ui.boxHeight(16),
            AppText.bold(
              proverb.scenario.isEmpty ? "DAILY PROVERB" : "MATCHED PROVERB",
              fontSize: 20,
            ),
            Ui.boxHeight(24),
            if (proverb.scenario.isNotEmpty)
              TitleValueWidget("Scenario", proverb.scenario),
            if (proverb.proverb.isNotEmpty)
              TitleValueWidget("Proverb", proverb.proverb),
            if (proverb.translation.isNotEmpty)
              TitleValueWidget("Translation", proverb.translation),
            if (proverb.wisdom.isNotEmpty)
              TitleValueWidget("Wisdom", proverb.wisdom),
            Ui.boxHeight(24),
            AppButton(
              onPressed: () {
                Get.back();
              },
              text: "Back to Home",
            ),
          ],
        ),
      ),
    );
  }
}

class QuizWidget extends StatelessWidget {
  const QuizWidget(this.quiz, {super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    RxInt qNo = 0.obs;
    List<QuizResult> qr = [];
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Obx(() {
          print(quiz.quizzes[qNo.value].type);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UniversalImage(Assets.quiz, width: 88),
              Ui.boxHeight(16),
              AppText.bold("QUIZ", fontSize: 20, color: AppColors.textColor),
              Ui.boxHeight(24),
              Ui.align(
                child: AppText.bold(
                  "Question ${qNo.value + 1}/${quiz.quizzes.length}:",
                  color: AppColors.accentColor,
                  fontSize: 18,
                ),
              ),
              if (quiz.quizzes[qNo.value].proverb.isNotEmpty)
                QuizTitleValueWidget(
                  "Proverb",
                  quiz.quizzes[qNo.value].proverb,
                ),
              if (quiz.quizzes[qNo.value].translation.isNotEmpty)
                QuizTitleValueWidget(
                  "Translation",
                  quiz.quizzes[qNo.value].translation,
                ),
              if (quiz.quizzes[qNo.value].context.isNotEmpty)
                QuizTitleValueWidget(
                  "Context",
                  quiz.quizzes[qNo.value].context,
                ),
              Ui.boxHeight(10),
              AppText.bold(
                "Choose the ${quiz.quizzes[qNo.value].type == "proverb_to_scenario" ? "proverb" : "context"} that best matches the ${quiz.quizzes[qNo.value].type == "scenario_to_proverb" ? "proverb" : "context"}:",
                color: AppColors.accentColor,
                fontSize: 16,
              ),
              Ui.boxHeight(24),
              ...List.generate(quiz.quizzes[qNo.value].options.length, (i) {
                final option = quiz.quizzes[qNo.value].options[i];
                return CurvedContainer(
                  border: Border.all(color: AppColors.primaryColor),
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(12),
                  onPressed: () async {
                    qr.add(
                      QuizResult(
                        id: quiz.quizzes[qNo.value].id,
                        choice: option.id,
                      ),
                    );
                    if (qNo.value < quiz.quizzes.length - 1) {
                      qNo.value++;
                    } else {
                      //submit
                      final f =
                          await Get.find<DashboardController>().submitQuiz(qr);
                      Get.back();
                      Get.dialog(
                        AlertDialog(
                          insetPadding: EdgeInsets.all(12),
                          contentPadding: EdgeInsets.all(0),
                          backgroundColor: AppColors.white,
                          content: QuizSummarywidget(f),
                        ),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: AppText.thin(
                          quiz.quizzes[qNo.value].type == "proverb_to_scenario"
                              ? "${option.proverb} (${option.translation})"
                              : option.context,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        color: AppColors.primaryColor,
                        margin: EdgeInsets.all(12),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo(this.isAppoint, {super.key});
  final bool isAppoint;

  @override
  Widget build(BuildContext context) {
    final sched = CurvedContainer(
      color: AppColors.accentColor.withOpacity(0.08),
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.thin("Scheduled ",color: AppColors.accentColor,fontSize: 10),
          AppIcon(Icons.circle,size: 16,),
          AppText.thin(" 8:30 - 10:00 AM ",fontSize: 10),
        ],
      ),
    );
    final rate  = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      AppIcon(Icons.star,color: Colors.yellow,),
      AppText.thin(" 4.0 ",fontSize: 10),
      AppText.thin("(192 Reviews) ",color: AppColors.accentColor,fontSize: 10),
      ],
    );
    final info = Row(
      children: [
        SizedBox(
          width: isAppoint ? 60 : 80,
            height: isAppoint ? 60 : 80,
          child: CurvedImage(
            "",
            w: isAppoint ? 60 : 80,
            h: isAppoint ? 60 : 80,
            radius: isAppoint ? 45 : 8,
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.medium("Dr. Drogba Mayowa", fontSize: 14),
            Ui.boxHeight(4),
            AppText.thin(
                isAppoint
                    ? "General Medicine"
                    : "Cardiologist at Healthylife Hospital",
                fontSize: 12,color: AppColors.lightTextColor),
                Ui.boxHeight(4),
                isAppoint ?  sched : rate

          ],
        ))
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: isAppoint
          ? info
          : CurvedContainer(
              color: AppColors.transparent,
              border: Border.all(color: AppColors.lightTextColor),
              padding: EdgeInsets.all(16),
              child: info,
            ),
    );
  }
}

class SettingsItemWidget extends StatelessWidget {
  SettingsItemWidget(
    this.title,
    this.desc, {
    this.onTap,
    this.onSwitchChanged,
    this.switchValue = false,
    this.icon,
    this.iconColor = AppColors.textColor,
    super.key,
  });
  final String title, desc;
  final dynamic icon;
  final Color iconColor;
  final Function()? onTap;
  final Function(bool)? onSwitchChanged;
  final bool switchValue;
  final RxBool curSwitchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    curSwitchValue.value = switchValue;
    final pp = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          AppIcon(icon, color: iconColor),
          Ui.boxWidth(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.thin(title),
                if (desc.isNotEmpty) Ui.boxHeight(8),
                if (desc.isNotEmpty)
                  AppText.thin(
                    desc,
                    fontSize: 14,
                    color: AppColors.lightTextColor,
                  ),
              ],
            ),
          ),
          Ui.boxWidth(24),
          if (onTap != null) AppIcon(Icons.chevron_right_rounded),
          if (onSwitchChanged != null)
            Obx(() {
              return Switch(
                activeTrackColor: AppColors.primaryColor,
                inactiveTrackColor: AppColors.disabledColor,
                inactiveThumbColor: AppColors.white,
                value: curSwitchValue.value,
                onChanged: (v) {
                  curSwitchValue.value = v;
                  onSwitchChanged!(v);
                },
              );
            }),
        ],
      ),
    );
    return InkWell(onTap: onTap, child: pp);
  }
}
