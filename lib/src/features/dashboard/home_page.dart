import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/features/dashboard/controllers/dashboard_controller.dart';
import 'package:qhcare/src/features/dashboard/game_page.dart';
import 'package:qhcare/src/features/dashboard/shared.dart';
import 'package:qhcare/src/global/model/user.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_textfield.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../global/ui/ui_barrel.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  // final controller = Get.find<DashboardController>();
  final RxBool isUpcoming = false.obs;

  @override
  void initState() {
    // controller.getDailyProverb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                Ui.boxHeight(24),
                CustomTextField.search(
                  "Search for Doctors,hospitals",
                  TextEditingController(),
                  () {},
                ),
                Ui.boxHeight(24),
                SugSpecialistWidget(isUpcoming),
                Ui.boxHeight(24),
                CategoryRowWidget(),
                Ui.boxHeight(24),
                MeetSpecialistWidget(),
                Ui.boxHeight(24),
                TipsWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TipsWidget extends StatelessWidget {
  const TipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleSeeAll("Enjoy Health Tips"),
        Ui.boxHeight(14),
        ...List.generate(3, (i) {
          return CurvedContainer(
            color: AppColors.lightTextColor.withOpacity(0.1),
            padding: EdgeInsets.all(12),
            // height: 132,
            width: Ui.width(context)-48,
            radius: 18,
            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 0),
            child: Row(
              children: [
                SizedBox(
                  width: 84,
                  height: 84,
                  child: CurvedImage(
                  Assets.defHealth,
                    w: 84,
                    h: 84,
                    fit: BoxFit.cover,
                  ),
                ),
                Ui.boxWidth(8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.bold("Benefits of sleeping early"),
                      Ui.boxHeight(8),
                      AppText.thin(
                          "Here are 10 reasons why you need to sleep early at night",fontSize: 12,maxlines: 2)
                    ],
                  ),
                )
              ],
            ),
          );
        })
      ],
    );
  }
}

class SugSpecialistWidget extends StatelessWidget {
  const SugSpecialistWidget(this.isUpcoming, {super.key});
  final RxBool isUpcoming;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          return TitleSeeAll(
              isUpcoming.value ? "Upcoming Schedule" : "Suggested Specialists");
        }),
        Ui.boxHeight(8),
        CurvedContainer(
          color: AppColors.primaryColor,
          padding: EdgeInsets.all(16),
          radius: 16,
          width: Ui.width(context) - 48,
          child: Obx(() {
            return Column(
              children: [
                AppHeader(
                  isHeader: false,
                  isUpcoming: isUpcoming.value,
                  isNotUpcoming: !isUpcoming.value,
                ),
                Ui.boxHeight(12),
                isUpcoming.value
                    ? CurvedContainer(
                        radius: 8,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        color: AppColors.white.withOpacity(0.08),
                        child: Row(
                          children: [
                            AppIcon(
                              Iconsax.calendar_outline,
                              color: AppColors.white,
                              size: 18,
                            ),
                            Ui.boxWidth(8),
                            AppText.thin("Monday, 14 December",
                                fontSize: 12, color: AppColors.white),
                            const Spacer(),
                            AppIcon(
                              Iconsax.clock_outline,
                              color: AppColors.white,
                              size: 18,
                            ),
                            Ui.boxWidth(8),
                            AppText.thin("09:00-12:00",
                                color: AppColors.white, fontSize: 12),
                          ],
                        ),
                      )
                    : Ui.align(
                        child: SizedBox(
                          width: Ui.width(context) / 2,
                          child: AppButton(
                            onPressed: () {
                              isUpcoming.value = !isUpcoming.value;
                            },
                            text: "Book Appointment",
                            color: AppColors.white,
                          ),
                        ),
                      )
              ],
            );
          }),
        )
      ],
    );
  }
}

class MeetSpecialistWidget extends StatelessWidget {
  const MeetSpecialistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.add,
      Icons.lightbulb_outline_rounded,
      Icons.monitor_heart,
      Icons.traffic_outlined,
      Icons.traffic_outlined
    ];
    final titles = [
      "G.Medicine",
      "Neurologic",
      "Cardiologist",
      "Orthopedic",
      "Transpedic"
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleSeeAll("Meet A Specialist"),
        Ui.boxHeight(14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (i) {
              return InkWell(
                onTap: (){
                  Get.to(DoctorsPage());
                },
                child: SizedBox(
                  width: Ui.width(context) / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.accentColor.withOpacity(0.08),
                        child: AppIcon(
                          icons[i],
                          color: AppColors.accentColor,
                        ),
                      ),
                      Ui.boxHeight(8),
                      AppText.thin(titles[i], fontSize: 12)
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

class CategoryRowWidget extends StatelessWidget {
  const CategoryRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      Iconsax.profile_2user_outline,
      Iconsax.danger_outline,
      Iconsax.folder_2_outline
    ];
    final descs = [
      "12 Waiting",
      "It's urgent, please prioritize",
      "My Records"
    ];
    final titles = ["Queue", "Triage", "Records"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (i) {
        return CurvedContainer(
          color: AppColors.lightTextColor.withOpacity(0.1),
          width: (Ui.width(context) - 64) / 3,
          height: 120,
          padding: EdgeInsets.all(12),
          radius: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                icons[i],
                color: AppColors.accentColor,
              ),
              Ui.boxHeight(8),
              AppText.thin(descs[i],
                  fontSize: 10,
                  color: AppColors.lightTextColor,
                  maxlines: 2,
                  alignment: TextAlign.center),
              Ui.boxHeight(8),
              AppText.medium(titles[i], fontSize: 14)
            ],
          ),
        );
      }),
    );
  }
}
