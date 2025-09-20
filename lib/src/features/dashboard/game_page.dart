import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';

import '../../app/app_barrel.dart';
import '../../global/ui/ui_barrel.dart';
import '../../global/ui/widgets/fields/custom_textfield.dart';
import 'shared.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt curIndex = 0.obs;
    final titles = ["Upcoming", "Completed", "Cancelled"];

    return SingleChildScrollView(
      child: Column(
        children: [
          Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  "Appointments",
                  action: CircleIcon(Icons.search),
                  home: UserProfilePic(),
                ),
                Ui.boxHeight(24),
                Row(
                  children: List.generate(3, (i) {
                    return Expanded(child: Obx(() {
                      return CurvedContainer(
                        color: i == curIndex.value
                            ? AppColors.primaryColor
                            : AppColors.white,
                        padding: EdgeInsets.all(8),
                        onPressed: () {
                          curIndex.value = i;
                        },
                        child: Center(
                          child: AppText.medium(
                            titles[i],
                            fontSize: 14,
                            color: i != curIndex.value
                                ? AppColors.primaryColor
                                : AppColors.white,
                          ),
                        ),
                      );
                    }));
                  }),
                ),
                Ui.boxHeight(24),
                TitleSeeAll(
                  "Today",
                  desc: "15 July, 2025",
                ),
                Ui.boxHeight(12),
                ...List.generate(3, (i) {
                  return DoctorInfo(true);
                }),
                Ui.boxHeight(24),
                TitleSeeAll(
                  "Tomorrow",
                  desc: "16 July, 2025",
                ),
                Ui.boxHeight(12),
                ...List.generate(3, (i) {
                  return DoctorInfo(true);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Ui.padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    "General Doctor",
                    action: CircleIcon(Icons.search),
                  ),
                  Ui.boxHeight(24),
                  TitleSeeAll("Nearby Doctor"),
                  Ui.boxHeight(12),
                  ...List.generate(10, (i) {
                    return DoctorInfo(false);
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorDetailPage extends StatelessWidget {
  const DoctorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final curDay = 0.obs;
    final curTime = 0.obs;
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final times = [
      "8:30",
      "9:30",
      "10:30",
      "11:30",
      "1:30",
      "2:30",
      "3:30",
      "4:30"
    ];
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            CustomAppBar(
              "Doctor Details",
              action: CircleIcon(
                Iconsax.heart_outline,
                bc: AppColors.accentColor.withOpacity(0.1),
                ic: AppColors.accentColor,
              ),
            ),
            Ui.boxHeight(24),
            DoctorInfo(
              false,
              useBorder: false,
            ),
            AppDivider(),
            Ui.boxHeight(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                featureIcon("8000+", "Patients", Iconsax.profile_2user_outline),
                featureIcon("12 yr+", "Experience", Iconsax.bag_outline),
                featureIcon("4.9", "Ratings", Iconsax.star_outline),
                featureIcon("6,653", "Reviews", Iconsax.message_2_outline),
              ],
            ),
            Ui.boxHeight(24),
            TitleValueWidget("About",
                "Lorem ipsum dolor et Lorem ipsum dolor et Lorem ipsum dolor et Lorem ipsum dolor et Lorem ipsum dolor et Lorem ipsum dolor et..."),
            TitleValueWidget("Working Time", "Mon - Wed 10am - 10pm"),
            TitleValueWidget("Schedule", "",
                valueWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(days.length, (i) {
                    return Obx(
                       () {
                        return CurvedContainer(
                          color: curDay.value == i
                              ? AppColors.primaryColor
                              : AppColors.accentColor.withOpacity(0.08),
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          radius: 100,
                          child: Column(
                            children: [
                              AppText.thin(days[i],
                                  fontSize: 12, color: curDay.value == i ? AppColors.white:AppColors.lightTextColor),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: curDay.value == i
                                    ? AppColors.white
                                    : AppColors.transparent,
                                child: AppText.thin("${14 + i}",
                                    fontSize: 12,
                                    color: curDay.value == i
                                        ? AppColors.primaryColor
                                        : AppColors.lightTextColor),
                              )
                            ],
                          ),
                          onPressed: () {
                            curDay.value = i;
                          },
                        );
                      }
                    );
                  }),
                )),
            TitleValueWidget("Select Time", "",valueWidget: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(times.length, (i) {
                    return Obx(
                       () {
                        return CurvedContainer(
                          width: (Ui.width(context)-72)/4,
                          color: curTime.value == i
                              ? AppColors.primaryColor
                              : AppColors.accentColor.withOpacity(0.08),
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          radius: 100,
                          child:Center(
                            child: AppText.thin(times[i],
                                    fontSize: 12, color: curTime.value == i ? AppColors.white:AppColors.lightTextColor),
                          ),
                              
                          onPressed: () {
                            curTime.value = i;
                          },
                        );
                      }
                    );
                  }),
                ),),
                Ui.boxHeight(16),
            AppButton(
              onPressed: () {},
              text: "Book Appointment",
            )
          ],
        ),
      ),
    );
  }

  featureIcon(String title, String desc, dynamic icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleIcon(
          icon,
          bc: AppColors.accentColor.withOpacity(0.1),
          ic: AppColors.accentColor,
        ),
        Ui.boxHeight(4),
        AppText.medium(title, fontSize: 14),
        Ui.boxHeight(4),
        AppText.thin(desc, fontSize: 12, color: AppColors.lightTextColor)
      ],
    );
  }
}
