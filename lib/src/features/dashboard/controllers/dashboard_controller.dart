import 'package:get/get.dart';
import 'package:qhcare/src/global/model/user.dart';

import '../repository/app_repo.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  Rx<Proverb> currentProverb = Proverb().obs;
  final appRepo = Get.find<AppRepo>();
  RxString currentUser = "".obs;
  Rx<Quiz> currentQuiz = Quiz().obs;

  getDailyProverb() async {
    final f = await appRepo.getDailyProverb();
    currentProverb.value = f ?? Proverb(scenario: "");
  }

  getCurrentQuiz(String username, String type, int no) async {
    final f = await appRepo.createQuiz(
      username,
      type.toLowerCase().replaceAll(" ", "_"),
      no,
    );
    currentQuiz.value = f ?? Quiz();
    currentUser.value = username;
  }

  Future<Proverb?> matchScenario(String title) async {
    final f = await appRepo.matchScenario(title);
    return f;
  }

  Future<QuizResults> submitQuiz(List<QuizResult> qr) async {
    final f = await appRepo.submitQuiz(
      currentUser.value,
      currentQuiz.value.id,
      qr,
    );
    return f;
  }
}
