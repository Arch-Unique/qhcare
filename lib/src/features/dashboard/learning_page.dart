import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/src_barrel.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        backAppBar(hasBack: false, title: "Learning"),
        AppDivider(),
        Spacer(),
        Ui.padding(
          child: Column(
            children: [
              UniversalImage(Assets.books, width: Ui.width(context) - 48),
              Ui.boxHeight(24),
              AppText.semiBold("Ẹ̀kọ́ ń bọ̀ wá!"),
              AppText.thin(
                "We’re cooking up something special to help you kó òwe dáadáa — from pronunciation to deep meanings and cultural roots.",
                fontSize: 14,
                alignment: TextAlign.center,
                color: AppColors.lightTextColor,
              ),
              Ui.boxHeight(24),
              AppText.thin("Ri dájú pé o yóò padà wá."),
              AppText.thin(
                "Wisdom is loading... 🧠⏳",
                fontSize: 14,
                color: AppColors.lightTextColor,
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        backAppBar(hasBack: false, title: "Notifications"),
        AppDivider(),
        Spacer(),
        Ui.padding(
          child: Column(
            children: [
              UniversalImage(Assets.books, width: Ui.width(context) - 48),
              Ui.boxHeight(24),
              AppText.semiBold("Ẹ̀kọ́ ń bọ̀ wá!"),
              AppText.thin(
                "We’re cooking up something special to help you kó òwe dáadáa — from pronunciation to deep meanings and cultural roots.",
                fontSize: 14,
                alignment: TextAlign.center,
                color: AppColors.lightTextColor,
              ),
              Ui.boxHeight(24),
              AppText.thin("Ri dájú pé o yóò padà wá."),
              AppText.thin(
                "Wisdom is loading... 🧠⏳",
                fontSize: 14,
                color: AppColors.lightTextColor,
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
