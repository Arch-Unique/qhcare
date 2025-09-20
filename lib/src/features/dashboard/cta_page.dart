import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/features/dashboard/ai_page.dart';
import 'package:qhcare/src/features/dashboard/controllers/dashboard_controller.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../app/app_barrel.dart';
import '../../global/ui/ui_barrel.dart';
import '../../global/ui/widgets/fields/custom_textfield.dart';
import '../../global/ui/widgets/others/containers.dart';
import 'shared.dart';

class CTAPage extends StatelessWidget {
  const CTAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Ui.padding(
          child: Column(
            children: [
              Image.asset(Assets.aichat),
              Ui.boxHeight(24),
              AppText.medium("Hi Temitope", fontSize: 20),
              AppText.thin(
                  "Hows your health today!  Get started by pressing the Start chat button",
                  alignment: TextAlign.center,
                  fontSize: 12),
              Ui.boxHeight(56),
              AppButton(
                onPressed: () {
                  Get.find<DashboardController>().messages.clear();
                  Get.to(CTAChatPage());
                },
                text: "Start Chat",
              ),
              Ui.boxHeight(24),
            ],
          ),
        ),
      ],
    );
  }
}

// class CTAChatPage extends StatelessWidget {
//   CTAChatPage({super.key});
//   final suggestions = [
//     "Not Feeling well",
//     "Report an Emergency",
//     "Follow up appointment",
//     "Others"
//   ];
//   final RxInt curAsk = 0.obs;
//   final tec = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomSheet: chatBox(),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Ui.padding(
//             child: Column(
//               children: [
//                 CustomAppBar(""),
//                 ...emptyChat(),
//                 Ui.boxHeight(24),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   emptyChat() {
//     return [
//       Image.asset(Assets.aichat),
//       AppText.medium("Hi Temitope", fontSize: 20),
//       AppText.thin("How can i help you today",
//           alignment: TextAlign.center, fontSize: 12),
//       Ui.boxHeight(8),
//       Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: List.generate(4, (i) {
//             return Obx(() {
//               return CurvedContainer(
//                 color: curAsk.value == i
//                     ? AppColors.primaryColor
//                     : AppColors.accentColor.withOpacity(0.08),
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 radius: 100,
//                 child: AppText.thin(suggestions[i],
//                     fontSize: 12,
//                     color: curAsk.value == i
//                         ? AppColors.white
//                         : AppColors.lightTextColor),
//                 onPressed: () {
//                   curAsk.value = i;
//                   tec.text = suggestions[i];
//                 },
//               );
//             });
//           }))
//     ];
//   }

//   chatBox() {
//     return CurvedContainer(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: CustomTextField(
//         "",
//         tec,
//         shdValidate: false,
//         prefixWidget: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CircleIcon(
//             Icons.add,
//             bc: AppColors.accentColor.withOpacity(0.08),
//             ic: AppColors.accentColor,
//             radius: 16,
//           ),
//         ),
//         suffixWidget: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: AppIcon(
//             Iconsax.send_1_bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ),
//     );
//   }

//   messageBox(bool isMe) {
//     return Row(
//       children: [
//         if (isMe) Spacer(),
//         if (!isMe)
//           Image.asset(
//             Assets.aichat,
//             width: 40,
//           ),
//         CurvedContainer(),
//         if (!isMe) Spacer(),
//         if (isMe)
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CurvedImage(
//               Assets.defDoctor,
//               h: 20,
//               w: 20,
//               radius: 20,
//               fit: BoxFit.cover,
//             ),
//           )
//       ],
//     );
//   }
// }
