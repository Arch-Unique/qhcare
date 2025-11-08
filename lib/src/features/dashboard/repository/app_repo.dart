import 'package:get/get.dart';
import 'package:qhcare/src/global/services/barrel.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../../global/model/user.dart';

class AppRepo extends GetxController {
  final apiService = Get.find<DioApiService>();

  Future<bool> bookDoctor(Booking booking) async {
    try {
      final response = await apiService.post(
        "/api/bookings",
        data: booking.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

    Future<String> chatAI(String msg) async {
    try {
      final response = await apiService.post(
        "/api/ai",
        data: {
          "userPrompt": msg,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
