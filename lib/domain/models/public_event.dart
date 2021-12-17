class EventModel {
  String title, type, address, country, city;
  DateTime datetimeEvent;

  EventModel(
      {required this.title,
      required this.type,
      required this.address,
      required this.country,
      required this.city,
      required this.datetimeEvent});

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
        title: map['title'],
        type: map['type'],
        address: map['venue']['address'],
        country: map['venue']['country'],
        city: map['venue']['city'],
        datetimeEvent: DateTime.parse(map['datetime_utc']));
  }
}
