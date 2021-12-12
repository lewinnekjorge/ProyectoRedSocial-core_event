import 'package:flutter/material.dart';
import 'widgets/events_card.dart';

class PublicEventsScreen extends StatefulWidget {
  const PublicEventsScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PublicEventsScreen> {
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return EventsCard(
          title: 'Final Mundial Colombia 2022',
          content: 'Oferta de Boletas de todas la plazas para que asistas',
          arch: 'Diamante',
          level: 'VIP',
          payment: 2500000,
          onCopy: () => {},
          onApply: () => {},
        );
      },
    );
  }
}
