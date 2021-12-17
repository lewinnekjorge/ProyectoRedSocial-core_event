import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_event/data/services/event_pool.dart';
import 'package:core_event/domain/models/public_event.dart';
import 'package:core_event/ui/pages/content/public_events/widgets/events_card.dart';
import 'package:core_event/domain/use_cases/controllers/connectivity.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<EventsScreen> {
  late EventPoolService service;
  late Future<List<EventModel>> futureEvents;
  late ConnectivityController connectivityController;

  @override
  void initState() {
    super.initState();
    service = EventPoolService();
    futureEvents = service.fecthData();
    connectivityController = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              EventModel event = items[index];
              return ResponseCard(
                title: event.title,
                type: event.type,
                address: event.address,
                country: event.country,
                city: event.city,
                datetimeEvent: event.datetimeEvent,
                onApply: () => {
                  Get.showSnackbar(
                    const GetSnackBar(
                      message: "Se ha separado este evento",
                      duration: Duration(seconds: 3),
                    ),
                  )
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
