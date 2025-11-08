import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qhcare/src/global/model/barrel.dart';

import '../ai_page.dart';
import '../repository/app_repo.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  final appRepo = Get.find<AppRepo>();
  RxString currentUser = "".obs;
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  RxBool isUpcoming = false.obs;
  RxList<Booking> myBookings = <Booking>[].obs;

// Updated sendMessage function in ChatController
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    messages.add(ChatMessage(
      text: message,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    // Add loading message
    messages.add(ChatMessage.loading());
    isLoading.value = true;

    try {
      final response = await appRepo.chatAI(message);

      // Remove loading message
      messages.removeWhere((msg) => msg.isLoading);

      final aiResponse = response;

      // Add AI response
      messages.add(ChatMessage(
        text: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      // Remove loading message
      messages.removeWhere((msg) => msg.isLoading);

      // Add error message
      messages.add(ChatMessage(
        text:
            "Sorry, I'm having trouble connecting right now. Please try again.",
        isUser: false,
        timestamp: DateTime.now(),
      ));

      print('Error sending message: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
