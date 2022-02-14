class Event {
  Event({
    required this.name,
    required this.userEmail,
    required this.startingTime,
    required this.endingTime,
    required this.startingLocation,
    required this.endingLocation,
    required this.school,
  });

  String name;
  String userEmail;
  DateTime startingTime;
  DateTime endingTime;
  String startingLocation;
  String endingLocation;
  String school;

  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
        name: json["name"],
        userEmail: json["userEmail"],
        startingTime: DateTime.parse(json["startingTime"]).toLocal(),
        endingTime: DateTime.parse(json["endingTime"]).toLocal(),
        startingLocation: json["startingLocation"],
        endingLocation: json["endingLocation"],
        school: json["school"]);
  }

  static Map<String, dynamic> toMap(Event event) {
    return {
      "name": event.name,
      "userEmail": event.userEmail,
      "startingTime": event.startingTime.toIso8601String(),
      "endingTime": event.endingTime.toIso8601String(),
      "startingLocation": event.startingLocation,
      "endingLocation": event.endingLocation,
      "school": event.school
    };
  }
}
