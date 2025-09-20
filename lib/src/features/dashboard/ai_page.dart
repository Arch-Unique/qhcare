
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qhcare/src/features/dashboard/controllers/dashboard_controller.dart';
import 'package:qhcare/src/features/dashboard/shared.dart';

import '../../global/ui/ui_barrel.dart';
import '../../global/ui/widgets/fields/custom_textfield.dart';
import '../../global/ui/widgets/others/containers.dart';
import '../../src_barrel.dart';

// Message model
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isLoading;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isLoading = false,
  });

  ChatMessage.loading()
      : text = "",
        isUser = false,
        timestamp = DateTime.now(),
        isLoading = true;
}

class CTAChatPage extends StatelessWidget {
  CTAChatPage({super.key});
  
  final suggestions = [
    "Not Feeling well",
    "Report an Emergency",
    "Follow up appointment",
    "Others"
  ];
  
  final RxInt curAsk = 0.obs;
  final tec = TextEditingController();
  final chatController = Get.find<DashboardController>();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: chatBox(),
      body: Column(
        children: [
          Ui.padding(
            child: CustomAppBar(""),
          ),
          Expanded(
            child: Obx(() {
              return chatController.messages.isEmpty
                  ? SingleChildScrollView(
                      child: Ui.padding(
                        child: Column(
                          children: [
                            Ui.boxHeight(40),
                            ...emptyChat(),
                            Ui.boxHeight(100), // Space for bottom sheet
                          ],
                        ),
                      ),
                    )
                  : chatView();
            }),
          ),
        ],
      ),
    );
  }

  Widget chatView() {
    return StreamBuilder<List<ChatMessage>>(
      stream: chatController.messages.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });

        return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 100, // Space for bottom sheet
          ),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final message = snapshot.data![index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: messageBox(message),
            );
          },
        );
      },
    );
  }

  emptyChat() {
    return [
      Image.asset(Assets.aichat),
      AppText.medium("Hi Temitope", fontSize: 20),
      AppText.thin("How can i help you today",
          alignment: TextAlign.center, fontSize: 12),
      Ui.boxHeight(8),
      Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(4, (i) {
            return Obx(() {
              return CurvedContainer(
                color: curAsk.value == i
                    ? AppColors.primaryColor
                    : AppColors.accentColor.withOpacity(0.08),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                radius: 100,
                child: AppText.thin(suggestions[i],
                    fontSize: 12,
                    color: curAsk.value == i
                        ? AppColors.white
                        : AppColors.lightTextColor),
                onPressed: () {
                  curAsk.value = i;
                  tec.text = suggestions[i];
                },
              );
            });
          }))
    ];
  }

  Widget formatAIResponse(String text, {Color? textColor, double fontSize = 10}) {
  List<TextSpan> spans = [];
  List<String> parts = text.split(RegExp(r'(\*\*\*.*?\*\*\*|\*\*.*?\*\*|\*.*?\*)'));
  
  for (int i = 0; i < parts.length; i++) {
    String part = parts[i];
    
    if (part.startsWith('***') && part.endsWith('***')) {
      // Bold and italic (though we'll just make it bold)
      spans.add(TextSpan(
        text: part.substring(3, part.length - 3),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: textColor ?? Colors.white,
        ),
      ));
    } else if (part.startsWith('**') && part.endsWith('**')) {
      // Bold
      spans.add(TextSpan(
        text: part.substring(2, part.length - 2),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: textColor ?? Colors.white,
        ),
      ));
    } else if (part.startsWith('*') && part.endsWith('*')) {
      // Italic (we'll make it slightly emphasized)
      spans.add(TextSpan(
        text: part.substring(1, part.length - 1),
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: textColor ?? Colors.white,
        ),
      ));
    } else {
      // Regular text
      if (part.isNotEmpty) {
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ));
      }
    }
  }
  
  return RichText(
    text: TextSpan(children: spans),
    textAlign: TextAlign.left,
  );
}


  chatBox() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: CurvedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  "Type your message...",
                  tec,
                  shdValidate: false,
                  hasBottomPadding: false,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleIcon(
                      Icons.add,
                      bc: AppColors.accentColor.withOpacity(0.08),
                      ic: AppColors.accentColor,
                      radius: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Obx(() {
                return GestureDetector(
                  onTap: chatController.isLoading.value
                      ? null
                      : () async {
                          if (tec.text.trim().isNotEmpty) {
                            final message = tec.text;
                            tec.clear();
                            await chatController.sendMessage(message);
                          }
                        },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: chatController.isLoading.value
                          ? AppColors.primaryColor.withOpacity(0.5)
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: chatController.isLoading.value
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : AppIcon(
                            Iconsax.send_1_bold,
                            color: Colors.white,
                            size: 16,
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

Widget messageBox(ChatMessage message) {
  if (message.isLoading) {
    return Row(
      children: [
        Image.asset(
          Assets.aichat,
          width: 40,
        ),
        SizedBox(width: 8),
        Expanded(
          child: CurvedContainer(
            color: AppColors.accentColor.withOpacity(0.08),
            padding: EdgeInsets.all(16),
            radius: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 8),
                AppText.thin("Thinking...", fontSize: 12),
              ],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if (message.isUser) Spacer(),
      if (!message.isUser)
        Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 4),
          child: Image.asset(
            Assets.aichat,
            width: 40,
          ),
        ),
      Expanded(
        flex: 3,
        child: CurvedContainer(
          color: message.isUser
              ? AppColors.primaryColor
              : AppColors.lightTextColor,
          padding: EdgeInsets.all(8),
          radius: 16,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: !message.isUser ? Radius.zero : Radius.circular(20),
            bottomRight: message.isUser ? Radius.zero : Radius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use formatted response for AI, regular text for user
              message.isUser
                  ? AppText.thin(
                      message.text,
                      fontSize: 12,
                      color: AppColors.white,
                    )
                  : formatAIResponse(
                      message.text,
                      textColor: AppColors.white,
                      fontSize: 12,
                    ),
            ],
          ),
        ),
      ),
      if (!message.isUser) Spacer(),
      if (message.isUser)
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4),
          child: CurvedImage(
            Assets.defDoctor,
            h: 40,
            w: 40,
            radius: 20,
            fit: BoxFit.cover,
          ),
        )
    ],
  );
}


  // String _formatTime(DateTime dateTime) {
  //   return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  // }
}