import 'package:get/get.dart';
import 'package:qhcare/src/global/services/barrel.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../../global/model/user.dart';

class AppRepo extends GetxController {
  final apiService = Get.find<DioApiService>();

  Future<Proverb?> getDailyProverb() async {
    final gt = await apiService.get(AppUrls.dailyProverb);
    if (gt.statusCode!.isSuccess()) {
      return Proverb.fromJson(gt.data);
    }
    return null;
  }

  Future<Proverb?> matchScenario(String scenario) async {
    final gt = await apiService.post(
      AppUrls.matchScenario,
      data: {"scenario": scenario},
    );
    if (gt.statusCode!.isSuccess()) {
      final p = Proverb(
        scenario: scenario,
        proverb: gt.data["response"],
        translation: "",
        wisdom: "",
      );
      return p;
    }
    Ui.showError(gt.data["error"] ?? "No Proverb found");
    return null;
  }

  Future<Quiz?> createQuiz(String username, String type, int no) async {
    final gt = await apiService.post(
      AppUrls.createQuiz,
      data: {"num_questions": no, "quiz_type": type, "user_name": username},
    );
    if (gt.statusCode!.isSuccess()) {
      return Quiz.fromJson(gt.data);
    }
    Ui.showError(gt.data["error"] ?? "No Quiz Found");
    return null;
  }

  Future<QuizResults> submitQuiz(
    String username,
    String id,
    List<QuizResult> qr,
  ) async {
    final dt = {
      "quiz_id": id,
      "user_name": username,
      "answers": qr.map((e) => e.toJson()).toList(),
    };
    final gt = await apiService.post(AppUrls.submitQuiz, data: dt);
    if (gt.statusCode!.isSuccess()) {
      return QuizResults.fromJson(gt.data);
    } else {
      throw gt.data["error"] ?? "No Quiz Found";
    }
  }
}
