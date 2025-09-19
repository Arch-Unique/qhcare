import 'dart:async';

import 'package:qhcare/src/global/model/user.dart';
import 'package:qhcare/src/global/services/barrel.dart';
import 'package:qhcare/src/plugin/jwt.dart';
import 'package:qhcare/src/src_barrel.dart';
import 'package:qhcare/src/utils/constants/prefs/prefs.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  Rx<User> currentUser = User().obs;
  RxBool hasOpenedOnboarding = false.obs;
  RxBool isLoggedIn = false.obs;
  final apiService = Get.find<DioApiService>();
  final prefService = Get.find<MyPrefService>();

  initUserConfig() async {
    await _hasOpened();
    await _setLoginStatus();
    if (isLoggedIn.value) {
      await _setCurrentUser();
    }
  }

  loginUser(String jwt, String refreshJwt) async {
    await _saveJWT(jwt, refreshJwt);
    await _saveUser();
  }

  logout() async {
    await apiService.post(AppUrls.logout);
    await _logout();
  }

  _hasOpened() async {
    bool a = prefService.get(MyPrefs.hasOpenedOnboarding) ?? false;
    if (a == false) {
      await prefService.save(MyPrefs.hasOpenedOnboarding, true);
    }
    hasOpenedOnboarding.value = false;
  }

  _saveUser() async {
    await prefService.saveAll({
      MyPrefs.mpLoggedInEmail: currentUser.value.email,
      MyPrefs.mpFirstName: currentUser.value.firstName,
      MyPrefs.mpLastName: currentUser.value.lastName,
      MyPrefs.mpLoggedInURLPhoto: currentUser.value.image,
    });
  }

  _logout() async {
    final b = prefService.get(MyPrefs.mpLogin3rdParty) ?? false;
    if (b) {
      // final c = await GoogleSignIn().isSignedIn();
      // if (c) {
      //   await GoogleSignIn().disconnect();
      // }
    }
    await prefService.eraseAllExcept(MyPrefs.hasOpenedOnboarding);
  }

  _saveJWT(String jwt, String refreshJwt) async {
    final msg = Jwt.parseJwt(jwt);
    await prefService.saveAll({
      MyPrefs.mpLoginExpiry: msg["exp"],
      MyPrefs.mpUserJWT: jwt,
      MyPrefs.mpUserID: msg["user_id"],
      MyPrefs.mpIsLoggedIn: true,
      MyPrefs.mpUserRefreshJWT: refreshJwt,
    });
  }

  _refreshToken() async {
    final res = await apiService.post(
      AppUrls.changePassword,
      data: {"refresh_token": prefService.get(MyPrefs.mpUserRefreshJWT)},
    );
    await _saveJWT(res.data["access_token"], res.data["refresh_token"]);
  }

  _setCurrentUser() async {
    currentUser.value.email = prefService.get(MyPrefs.mpLoggedInEmail);
    currentUser.value.id = prefService.get(MyPrefs.mpUserID);
    final res = await apiService.get(
      "${AppUrls.getUser}?user_id=${currentUser.value.email}",
    );
    final user = User.fromJson(res.data);
    currentUser.value.firstName = user.firstName;
    currentUser.value.lastName = user.lastName;
    currentUser.value.image = user.image;
    _saveUser();
    //_listenToRefreshTokenExpiry();
  }

  refreshUser() async {
    final res = await apiService.get(
      "${AppUrls.getUser}?user_id=${currentUser.value.email}",
    );
    final user = User.fromJson(res.data);
    currentUser.value.firstName = user.firstName;
    currentUser.value.lastName = user.lastName;
    currentUser.value.image = user.image;
    currentUser.refresh();
    _saveUser();
  }

  _setLoginStatus() async {
    final e = prefService.get(MyPrefs.mpLoginExpiry) ?? 0;
    if (e != 0 && DateTime.now().millisecondsSinceEpoch > e * 1000) {
      //await _refreshToken();
      isLoggedIn.value = true;
    }
    isLoggedIn.value = prefService.get(MyPrefs.mpIsLoggedIn) ?? false;
  }

  _listenToRefreshTokenExpiry() {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      final e = prefService.get(MyPrefs.mpLoginExpiry) ?? 0;
      if (e == 0) {
        timer.cancel();
      } else if (DateTime.now().millisecondsSinceEpoch - (e * 1000) > 100000) {
        await _refreshToken();
      }
    });
  }

  addToFavs(String id) async {
    final e = prefService.get<List>(MyPrefs.mpFavourites) ?? [];
    e.add(id);
    await prefService.save(MyPrefs.mpFavourites, e);
  }

  removeFromFavs(String id) async {
    final e = prefService.get<List>(MyPrefs.mpFavourites) ?? [];
    e.removeWhere((f) => f.toString() == id);
    await prefService.save(MyPrefs.mpFavourites, e);
  }

  List<String> getFavs() {
    final e = prefService.get<List>(MyPrefs.mpFavourites) ?? [];
    return e.map((a) => a.toString()).toList();
  }
}
