import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:core_event/domain/models/public_event.dart';
import 'package:core_event/domain/services/misiontic_interface.dart';

class EventPoolService implements MisionTicService {
  final String baseUrl = 'api.seatgeek.com';
  final String clientID = 'MjM5OTUyMTZ8MTYzNDY2NjQ2MC45MjM4MjQz';

  @override
  Future<List<EventModel>> fecthData({int limit = 10, Map? map}) async {
    var queryParameters = {'client_id': clientID};
    var uri = Uri.https(baseUrl, '/2/events', queryParameters);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // We add our service ApiKey to the request headers
        //'key': apiKey
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<EventModel> events = [];
      for (var event in res['events']) {
        events.add(EventModel.fromJson(event));
      }
      return events;
    } else {
      throw Exception('Error on request');
    }
  }
}
