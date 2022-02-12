class Event {
  Event({
    required this.name,
    required this.userEmail,
    required this.startingTime,
    required this.endingTime,
    required this.startingLocation,
    required this.endingLocation,
  });

  String name;
  String userEmail;
  DateTime startingTime;
  DateTime endingTime;
  String startingLocation;
  String endingLocation;

  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
      name: json["name"],
      userEmail: json["userEmail"],
      startingTime: DateTime.parse(json["startingTime"]),
      endingTime: DateTime.parse(json["endingTime"]),
      startingLocation: json["startingLocation"],
      endingLocation: json["endingLocation"],
    );
  }

  static Map<String, dynamic> toMap(Event event) {
    return {
      "name": event.name,
      "userEmail": event.userEmail,
      "startingTime": event.startingTime.toIso8601String(),
      "endingTime": event.endingTime.toIso8601String(),
      "startingLocation": event.startingLocation,
      "endingLocation": event.endingLocation,
    };
  }
}
