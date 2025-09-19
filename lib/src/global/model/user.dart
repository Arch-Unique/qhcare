class User {
  String firstName, lastName, email, image, id;
  bool confirmed;

  User(
      {this.firstName = "Fisayo",
      this.lastName = "Fosudo",
      this.image = "",
      this.id = "",
      this.confirmed = false,
      this.email = "fisayofosudo@gmail.com"});

  String get fullName => "$firstName $lastName";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      image: json['user_image'] ?? "",
      id: json['user_id'] ?? "",
      email: json['email'] ?? "",
      confirmed: json['confirmed_email'] ?? false,
    );
  }
}

class Proverb {
  String id, proverb, translation, wisdom, scenario;

  Proverb({
    this.id = "",
    this.proverb = "",
    this.translation = "",
    this.wisdom = "",
    this.scenario = "",
  });

  factory Proverb.fromJson(Map<String, dynamic> json) {
    return Proverb(
      id: json['id'] ?? "",
      proverb: json['proverb'] ?? "",
      translation: json['translation'] ?? "",
      wisdom: json['wisdom'] ?? "",
      scenario: json['scenario'] ?? "",
    );
  }
}

class Quiz {
  String id;
  List<QuizItem> quizzes;

  Quiz({this.id = "", this.quizzes = const []});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
        id: json['quiz_id'] ?? "",
        quizzes: ((json["quiz"]) as List<dynamic>)
            .map((e) => QuizItem.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class QuizResult {
  int id;
  int choice;

  QuizResult({
    this.id = 0,
    this.choice = 0,
  });

  Map<String, dynamic> toJson() {
    return {"question_id": id, "choice": choice};
  }
}

class QuizItem {
  String type, context, proverb, translation;
  int id;
  List<QuizOptionItem> options;

  QuizItem(
      {this.id = 0,
      this.type = "",
      this.context = "",
      this.proverb = "",
      this.translation = "",
      this.options = const []});

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(
        id: json['question_id'] ?? 0,
        proverb: json['proverb'] ?? "",
        type: json['type'] ?? "",
        translation: json['translation'] ?? "",
        context: json['context'] ?? "",
        options: ((json["options"]) as List<dynamic>)
            .map((e) => QuizOptionItem.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class QuizOptionItem {
  int id;
  String context, proverb, translation;

  QuizOptionItem({
    this.id = 0,
    this.context = "",
    this.proverb = "",
    this.translation = "",
  });

  factory QuizOptionItem.fromJson(Map<String, dynamic> json) {
    return QuizOptionItem(
      id: json['index'] ?? 0,
      proverb: json['proverb'] ?? "",
      translation: json['translation'] ?? "",
      context: json['context'] ?? "",
    );
  }
}

class QuizBreakdown {
  final int correct;
  final int total;
  final double percentage;

  QuizBreakdown({
    required this.correct,
    required this.total,
    required this.percentage,
  });

  factory QuizBreakdown.fromJson(Map<String, dynamic> json) {
    return QuizBreakdown(
      correct: json['correct'] as int,
      total: json['total'] as int,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'total': total,
      'percentage': percentage,
    };
  }
}

class QuizBreakdownGroup {
  final QuizBreakdown proverbToScenario;
  final QuizBreakdown scenarioToProverb;

  QuizBreakdownGroup({
    required this.proverbToScenario,
    required this.scenarioToProverb,
  });

  factory QuizBreakdownGroup.fromJson(Map<String, dynamic> json) {
    return QuizBreakdownGroup(
      proverbToScenario: QuizBreakdown.fromJson(json['proverb_to_scenario']),
      scenarioToProverb: QuizBreakdown.fromJson(json['scenario_to_proverb']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proverb_to_scenario': proverbToScenario.toJson(),
      'scenario_to_proverb': scenarioToProverb.toJson(),
    };
  }
}

class QuizSubmissionResult {
  final int questionId;
  final String type;
  final bool correct;
  final String selected;
  final String correctAnswer;
  final String message;

  QuizSubmissionResult({
    required this.questionId,
    required this.type,
    required this.correct,
    required this.selected,
    required this.correctAnswer,
    required this.message,
  });

  factory QuizSubmissionResult.fromJson(Map<String, dynamic> json) {
    return QuizSubmissionResult(
      questionId: json['question_id'] as int,
      type: json['type'] as String,
      correct: json['correct'] as bool,
      selected: json['selected'] as String,
      correctAnswer: json['correct_answer'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'type': type,
      'correct': correct,
      'selected': selected,
      'correct_answer': correctAnswer,
      'message': message,
    };
  }
}

class QuizResults {
  final int score;
  final int total;
  final double percentage;
  final String grade;
  final QuizBreakdownGroup breakdown;
  final List<QuizSubmissionResult> results;
  final String resultsFile;
  final String csvContent;

  QuizResults({
    required this.score,
    required this.total,
    required this.percentage,
    required this.grade,
    required this.breakdown,
    required this.results,
    required this.resultsFile,
    required this.csvContent,
  });

  factory QuizResults.fromJson(Map<String, dynamic> json) {
    return QuizResults(
      score: json['score'] as int,
      total: json['total'] as int,
      percentage: (json['percentage'] as num).toDouble(),
      grade: json['grade'] as String,
      breakdown: QuizBreakdownGroup.fromJson(json['breakdown']),
      results: (json['results'] as List)
          .map((item) => QuizSubmissionResult.fromJson(item))
          .toList(),
      resultsFile: json['results_file'] as String,
      csvContent: json['csv_content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'total': total,
      'percentage': percentage,
      'grade': grade,
      'breakdown': breakdown.toJson(),
      'results': results.map((result) => result.toJson()).toList(),
      'results_file': resultsFile,
      'csv_content': csvContent,
    };
  }

  // Helper methods
  double get proverbToScenarioPercentage =>
      breakdown.proverbToScenario.percentage;
  double get scenarioToProverbPercentage =>
      breakdown.scenarioToProverb.percentage;

  List<QuizSubmissionResult> get correctAnswers =>
      results.where((r) => r.correct).toList();
  List<QuizSubmissionResult> get incorrectAnswers =>
      results.where((r) => !r.correct).toList();

  List<QuizSubmissionResult> getResultsByType(String type) =>
      results.where((r) => r.type == type).toList();
}
