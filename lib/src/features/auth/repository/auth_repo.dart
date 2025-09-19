import 'package:qhcare/src/global/model/user.dart' as app;
import 'package:qhcare/src/global/services/barrel.dart';
import 'package:qhcare/src/global/ui/ui_barrel.dart';
import 'package:qhcare/src/src_barrel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo extends GetxController {
  final apiService = Get.find<DioApiService>();
  final prefService = Get.find<MyPrefService>();
  final appService = Get.find<AppService>();

  login(String email, String password) async {
    final res = await apiService.post(
      AppUrls.login,
      data: {"email": email, "password": password, "userType": "user"},
      hasToken: false,
    );
    if (res.statusCode!.isSuccess()) {
      appService.currentUser.value = app.User.fromJson(res.data["user_data"]);
      await appService.loginUser(res.data["token"], res.data["token"]);
    } else {
      throw res.data["message"];
    }
  }

  loginSocial(ThirdPartyTypes tpt) async {
    String token = "";
    switch (tpt) {
      // case ThirdPartyTypes.apple:
      //   token = await _loginWithApple();
      //   break;
      // case ThirdPartyTypes.google:
      //   token = await _loginWithGoogle();
      //   break;
      // case ThirdPartyTypes.facebook:
      //   token = await _loginWithFacebook();
      //   break;
      default:
    }

    final res = await apiService.post(
      AppUrls.loginSocial,
      data: {"token": token},
      hasToken: false,
    );
    if (res.statusCode!.isSuccess()) {
      await appService.loginUser(
        res.data["access_token"],
        res.data["refresh_token"],
      );
    }
  }

  register(
    String fullname,
    // String lastname,
    String email,
    String password,
  ) async {
    if (fullname.split(" ").length == 1) {
      throw "Last Name Required e.g John Doe";
    }
    final res = await apiService.post(
      AppUrls.register,
      data: {
        "first_name": fullname.split(" ")[0],
        "last_name": fullname.split(" ")[1],
        "email": email,
        "password": password,
      },
      hasToken: false,
    );
    if (res.statusCode!.isSuccess()) {
      // await appService.loginUser(
      //     res.data["access_token"], res.data["refresh_token"]);
    } else {
      throw res.data["message"];
    }
  }

  // Future<String> forgotPassword(String email) async {
  //   final res = await apiService.post(AppUrls.forgotPassword,
  //       data: {
  //         "email": email,
  //         "userType": "user",
  //         "web_domain": AppUrls.webDomain
  //       },
  //       hasToken: false);
  //   if (res.statusCode!.isSuccess()) {
  //     return res.data;
  //   } else {
  //     throw res.data["message"] ?? res.data;
  //   }
  // }

  // Future<String> _loginWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   final user = await FirebaseAuth.instance.signInWithCredential(credential);
  //   final token = await user.user?.getIdToken();
  //   return token ?? "";
  // }

  // Future<String> _loginWithApple() async {
  //   final appleProvider = AppleAuthProvider();
  //   final user = await FirebaseAuth.instance.signInWithProvider(appleProvider);
  //   final token = await user.user?.getIdToken();
  //   return token ?? "";
  // }

  // Future<String> _loginWithFacebook() async {
  //   // final LoginResult loginResult = await FacebookAuth.instance.login();

  //   // final OAuthCredential facebookAuthCredential =
  //   //     FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

  //   // final user = await FirebaseAuth.instance
  //   //     .signInWithCredential(facebookAuthCredential);
  //   final token = await user.user?.getIdToken();
  //   return token ?? "";
  // }
}
