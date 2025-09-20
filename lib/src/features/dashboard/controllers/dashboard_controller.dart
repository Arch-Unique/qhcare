import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../ai_page.dart';
import '../repository/app_repo.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  final appRepo = Get.find<AppRepo>();
  RxString currentUser = "".obs;
    final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final Dio dio = Dio();
  
  // Replace with your OpenRouter API key
  final String apiKey = String.fromEnvironment("OPENROUTER_KEY");
  final String apiUrl = "https://openrouter.ai/api/v1/chat/completions";

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
    final response = await dio.post(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': 'google/gemma-3-27b-it:free',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a helpful medical assistant. Provide helpful and accurate information while being empathetic and professional. Keep responses concise and under 100 words when possible. Use markdown formatting with * for emphasis and ** for strong emphasis.'
          },
          {
            'role': 'user',
            'content': message,
          }
        ],
        'max_tokens': 200, // Reduced from 1000 to get shorter responses
        'temperature': 0.7,
      },
    );

    // Remove loading message
    messages.removeWhere((msg) => msg.isLoading);
    
    final aiResponse = response.data['choices'][0]['message']['content'];
    
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
      text: "Sorry, I'm having trouble connecting right now. Please try again.",
      isUser: false,
      timestamp: DateTime.now(),
    ));
    
    print('Error sending message: $e');
  } finally {
    isLoading.value = false;
  }
}
}
