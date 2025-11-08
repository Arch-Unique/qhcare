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

class Booking {
  String day, time, doctor;
  int date;
  bool isEmergency;

  Booking(
      {this.day = "Mon",
      this.date = 14,
      this.doctor = "Dr Mayowa",
      this.time = "8:30",
      this.isEmergency = false});

  Map<String, dynamic> toJson() {
    return {
      "day": day,
      "date": date,
      "doctor": doctor,
      "doctorId": 1,
      "time": time,
      "isUrgent": isEmergency,
      "patientName": "Fisayo Fosudo",
      "patientEmail": "fisayofosudo@gmail.com"
    };
  }
}
