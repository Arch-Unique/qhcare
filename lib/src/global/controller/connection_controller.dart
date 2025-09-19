import 'package:qhcare/src/utils/utils_barrel.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/dio_api_service.dart';

class ConnectionController extends GetxController {
  RxBool isConnected = false.obs;
  late Stream<List<ConnectivityResult>> _connectivityStream;
  final controller = Get.find<DioApiService>();

  init() {
    isConnected.value = true;
    _connectivityStream = Connectivity().onConnectivityChanged;
    _connectivityStream.listen((result) {
      isConnected.value = !result.contains(ConnectivityResult.none);
      if (!isConnected.value) {
        controller.currentErrorType.value = ErrorTypes.noInternet;
      }
    });
  }
}
