import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_event/domain/controller/newstatus.dart';
import 'package:core_event/domain/models/user_status.dart';
import 'package:core_event/domain/use_cases/status_management.dart';
import 'package:flutter/material.dart';
import 'package:core_event/ui/widgets/card.dart';
import 'package:get/get.dart';

class StateCard extends StatelessWidget {
  final String title, content, picUrl;
  //final int index;
  final VoidCallback onDelete;
  //late StatusManager manager = StatusManager();
  //late Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream;

  // StateCard constructor
  StateCard(
      {Key? key,
      required this.title,
      //required this.index,
      required this.content,
      required this.picUrl,
      required this.onDelete})
      : super(key: key);

  // @override
  // void initState() {
  //   //super.initState();
  //   manager = StatusManager();
  //   statusesStream = manager.getStatusesStream();
  // }

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      key: const Key("statusCard"),
      title: title,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topLeftWidget widget as an Avatar
      topLeftWidget: SizedBox(
        height: 48.0,
        width: 48.0,
        child: Center(
          child: CircleAvatar(
            minRadius: 14.0,
            maxRadius: 14.0,
            backgroundImage: NetworkImage(picUrl),
          ),
        ),
      ),
      // topRightWidget widget as an IconButton
      topRightWidget: IconButton(
          icon: Icon(
            Icons.delete,
            color: primaryColor,
          ),
          onPressed: onDelete,//() {
            //StatusController statusController = Get.find();

            //print(statusController.liststados[index]);
            //UserStatus status = statusController.liststados[index];
            //manager.removeStatus(status);
            //statusController.borrarestado(index);
          //}
          ),
    );
  }
}
