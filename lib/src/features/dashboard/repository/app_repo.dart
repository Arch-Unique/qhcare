import 'package:get/get.dart';
import 'package:qhcare/src/global/services/barrel.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/src_barrel.dart';

import '../../../global/model/user.dart';

class AppRepo extends GetxController {
  final apiService = Get.find<DioApiService>();

  Future<Proverb?> getDailyProverb() async {
  //     const completion = await openai.chat.completions.create({
  //   model: "google/gemma-3-27b-it:free",
  //   messages: [
  //     { role: "system", content: systemPrompt },
  //     { role: "user", content: userPrompt },
  //   ],
  //   temperature: temperature,
  //   top_p: 0.9,
  // });

  // return completion.choices[0].message.content;
    final gt = await apiService.get(AppUrls.dailyProverb);
    if (gt.statusCode!.isSuccess()) {
      return Proverb.fromJson(gt.data);
    }
    return null;
  }
}
