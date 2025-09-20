import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/global/ui/widgets/fields/custom_textfield.dart';
import 'package:qhcare/src/global/ui/widgets/others/containers.dart';
import 'package:qhcare/src/src_barrel.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Ui.padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bold("Chats"),
          Ui.boxHeight(16),
          CustomTextField.search(
              "Search chats and messages", TextEditingController(), () {}),
          Ui.boxHeight(16),
          ...List.generate(2, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CurvedImage(
                    Assets.defDoctor,
                    h: 48,
                    w: 48,
                    radius: 48,
                    fit: BoxFit.cover,
                  ),
                  Ui.boxWidth(16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium("Dr. Drogba Mayowa", fontSize: 14),
                        AppText.thin("Thank you for the time",
                            fontSize: 12, color: AppColors.lightTextColor),
                      ],
                    ),
                  ),
                  AppText.thin("20 mins ago",fontSize: 10,color: AppColors.lightTextColor),
                       
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

// class NotifPage extends StatelessWidget {
//   const NotifPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         backAppBar(hasBack: false, title: "Notifications"),
//         AppDivider(),
//         Spacer(),
//         Ui.padding(
//           child: Column(
//             children: [
//               UniversalImage(Assets.books, width: Ui.width(context) - 48),
//               Ui.boxHeight(24),
//               AppText.semiBold("Ẹ̀kọ́ ń bọ̀ wá!"),
//               AppText.thin(
//                 "We’re cooking up something special to help you kó òwe dáadáa — from pronunciation to deep meanings and cultural roots.",
//                 fontSize: 14,
//                 alignment: TextAlign.center,
//                 color: AppColors.lightTextColor,
//               ),
//               Ui.boxHeight(24),
//               AppText.thin("Ri dájú pé o yóò padà wá."),
//               AppText.thin(
//                 "Wisdom is loading... 🧠⏳",
//                 fontSize: 14,
//                 color: AppColors.lightTextColor,
//               ),
//             ],
//           ),
//         ),
//         Spacer(),
//       ],
//     );
//   }
// }
