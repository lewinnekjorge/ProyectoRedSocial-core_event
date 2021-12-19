// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:core_event/ui/widgets/card.dart';

class ResponseCard extends StatelessWidget {
  final String title, type, address, country, city;
  final DateTime datetimeEvent;
  final VoidCallback onApply;

  // OfferCard constructor
  const ResponseCard(
      {Key? key,
      required this.title,
      required this.type,
      required this.address,
      required this.country,
      required this.city,
      required this.datetimeEvent,
      required this.onApply})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      key: const Key("eventsCard"),
      title: "Titulo: $title",
      content: Text(
        "Tipo de evento: $type",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topRightWidget widget as an IconButton
      topRightWidget: IconButton(
        //key: const ValueKey("btnCopiar"),
        icon: Icon(
          Icons.copy_outlined,
          //key: const ValueKey("btnCopiar"),
          color: primaryColor,
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(
              text:
                  '${title} -  Es un : ${type} - Pais : ${country} - Ciudad : ${city} - Direcciòn : ${address} - A las : ${datetimeEvent.toString()}'));
          Get.showSnackbar(
            const GetSnackBar(
              key: Key("copiado"),
              message:
                  "Se ha copiado el evento al portapapeles, para que lo compartas por chat.",
              icon: Icon(Icons.copy_rounded, color: Colors.black),
              duration: Duration(seconds: 8),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.orange,
            ),
          );
        },
      ),
      // extraContent widget as a column that contains more details about the offer
      // and an extra action (onApply)
      extraContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.wb_cloudy,
                color: primaryColor,
              ),
            ),
            Text(
              " Pais: $country",
              style: Theme.of(context).textTheme.caption,
            ),
            const Spacer(),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.map,
                color: primaryColor,
              ),
            ),
            Text(
              " Ciudad: $city",
              style: Theme.of(context).textTheme.caption,
            ),
            const Spacer(),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.location_city_rounded,
                color: primaryColor,
              ),
            ),
            Text(
              " $address",
              style: Theme.of(context).textTheme.caption,
            ),
            const Spacer(),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.date_range,
                color: primaryColor,
              ),
            ),
            Text(
              " ${datetimeEvent.toString()}",
              style: Theme.of(context).textTheme.caption,
            ),
          ]),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
