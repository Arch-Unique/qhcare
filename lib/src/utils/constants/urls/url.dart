abstract class AppUrls {
  static const String baseURL =
      'https://yoruba-proverb-quiz-service.onrender.com';

  //auth repo
  static const String login = "/login";
  static const String loginSocial = "/login-social";
  static const String logout = "/logout";
  static const String register = "/register";
  static const String forgotPassword = "/forgot-password";

  //profile repo
  static const String getUser = "/user";
  static const String updateUser = "$getUser/update-profile";
  static const String changePassword = "/update-password";

  static const String dailyProverb = "/daily_proverb";
  static const String matchScenario = "/match_scenario";
  static const String createQuiz = "/create_quiz";
  static const String checkAnswer = "/check_answer";
  static const String submitQuiz = "/submit_quiz";
}
