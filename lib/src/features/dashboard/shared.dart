import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/features/dashboard/game_page.dart';
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
  RxInt selectedIndex = 0.obs;
  final controller = Get.find<DashboardController>();
  final icons = [
    Iconsax.home_1_outline,
    Iconsax.calendar_1_outline,
    Assets.aiicon,
    Iconsax.message_2_outline,
    Iconsax.setting_2_outline
  ];
  final titles = ["Home", "Appointment", "QHCare", "Chat", "Settings"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: CurvedContainer(
        borderRadius: BorderRadius.circular(
          100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (i) {
            return navItem(i);
          }),
        ),
      ),
    );
  }

  navItem(int i) {
    final icon = icons[i];
    final title = titles[i];

    return Obx(() {
      final isActive = selectedIndex.value == i;
      return isActive
          ? CurvedContainer(
              radius: 100,
              onPressed: () {
                selectedIndex.value = i;
                controller.currentIndex.value = i;
              },
              padding: EdgeInsets.all(10),
              color: AppColors.primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(
                    icon,
                    color: AppColors.white,
                  ),
                  Ui.boxWidth(4),
                  AppText.bold(title, fontSize: 12, color: AppColors.white)
                ],
              ),
            )
          : InkWell(
              onTap: () {
                selectedIndex.value = i;
                controller.currentIndex.value = i;
              },
              child: AppIcon(
                icon,
                color: AppColors.lightTextColor,
              ),
            );
    });
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
            CircleIcon(
              Iconsax.notification_bold,
              vb: () {
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
  const TitleSeeAll(this.title, {this.desc = "See All", super.key});
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bold(title),
        AppText.bold(desc, fontSize: 14, color: AppColors.primaryColor)
      ],
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon(this.icon, {this.vb, this.ic, this.bc,this.radius=24, super.key});
  final dynamic icon;
  final VoidCallback? vb;
  final Color? ic, bc;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: vb,
      child: CircleAvatar(
        backgroundColor: bc ?? AppColors.lightTextColor.withOpacity(0.08),
        radius: radius,
        child: AppIcon(
          icon,
          color: ic ?? AppColors.textColor,
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.title, {this.action, this.home, super.key});
  final String title;
  final Widget? action, home;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        home ??
            CircleIcon(Icons.chevron_left, vb: () {
              Get.back();
            }),
        AppText.bold(title),
        if (action != null) action!
      ],
    );
  }
}

class TitleValueWidget extends StatelessWidget {
  const TitleValueWidget(this.title, this.value, {this.valueWidget, super.key});
  final String title, value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        AppText.bold("$title:", fontSize: 14),
        Ui.boxHeight(4),

        //if value contains HTML string
        if (value.contains("<") && value.contains(">")) Html(data: value),

        //if value is plain text
        if (value.isNotEmpty && !value.contains("<") && !value.contains(">"))
          AppText.thin(value, color: AppColors.lightTextColor, fontSize: 12),

        if (valueWidget != null) valueWidget!,
        Ui.boxHeight(12),
      ],
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo(this.isAppoint, {this.useBorder = true, super.key});
  final bool isAppoint, useBorder;

  @override
  Widget build(BuildContext context) {
    final sched = CurvedContainer(
      color: AppColors.accentColor.withOpacity(0.08),
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.thin("Scheduled ",
              color: AppColors.accentColor, fontSize: 10),
          AppIcon(
            Icons.circle,
            size: 4,
          ),
          AppText.thin(" 8:30 - 10:00 AM ", fontSize: 10),
        ],
      ),
    );
    final rate = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          Icons.star,
          color: Colors.yellow,
        ),
        AppText.thin(" 4.0 ", fontSize: 10),
        AppText.thin("(192 Reviews) ",
            color: AppColors.accentColor, fontSize: 10),
      ],
    );
    final info = Row(
      children: [
        SizedBox(
          width: isAppoint ? 60 : 80,
          height: isAppoint ? 60 : 80,
          child: CurvedImage(
            Assets.defDoctor,
            fit: BoxFit.cover,
            w: isAppoint ? 60 : 80,
            h: isAppoint ? 60 : 80,
            radius: isAppoint ? 45 : 8,
          ),
        ),
        Ui.boxWidth(12),
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
                fontSize: 12,
                color: AppColors.lightTextColor),
            Ui.boxHeight(4),
            isAppoint ? sched : rate
          ],
        ))
      ],
    );

    return InkWell(
      onTap: () {
        Get.to(DoctorDetailPage());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: isAppoint
            ? info
            : CurvedContainer(
                color: AppColors.transparent,
                border: useBorder
                    ? Border.all(color: AppColors.lightTextColor)
                    : null,
                padding: EdgeInsets.all(12),
                radius: 8,
                child: info,
              ),
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
