import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_event/domain/controller/newstatus.dart';
import 'package:core_event/domain/use_cases/status_management.dart';
import 'package:core_event/ui/pages/content/user_feeds/widgets/newcard.dart';
import 'package:core_event/ui/pages/content/user_feeds/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> {
  late final StatusManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream;
  final items = [];
  @override
  void initState() {
    super.initState();
    manager = StatusManager();
    statusesStream = manager.getStatusesStream();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<StatusController>(builder: (statuscontrolador){
      return Stack(
        children: [
          ListView.builder(
            itemCount: statuscontrolador.liststados.length,
            itemBuilder: (context, index) {
              return StateCard(
                index: index,
                title: statuscontrolador.liststados[index].title,//'Prueba',
                content: statuscontrolador.liststados[index].message,//'Lorem ipsum dolor sit amet.',
                picUrl: statuscontrolador.liststados[index].picUrl,//'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
                onDelete: () => {},
              );
            },
          ),
        Positioned(
            right: 20,
            bottom: 30,
            child: FloatingActionButton(
              onPressed: () {
                Get.dialog(
                  PublishDialog(manager: manager,)
                );
              },
              child: const Icon(Icons.add),
            ))
      ],
    );
    });
    
  }
}