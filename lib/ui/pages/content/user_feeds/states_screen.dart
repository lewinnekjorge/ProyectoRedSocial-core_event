import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:core_event/domain/controller/newstatus.dart';
import 'package:core_event/domain/models/user_status.dart';
import 'package:core_event/domain/use_cases/controllers/authentication.dart';
import 'package:core_event/domain/use_cases/controllers/connectivity.dart';
import 'package:core_event/domain/use_cases/status_management.dart';
import 'package:core_event/ui/pages/content/user_feeds/widgets/newcard.dart';
import 'package:core_event/ui/pages/content/user_feeds/widgets/state_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late ConnectivityController controller;

  final items = [];
  @override
  void initState() {
    super.initState();
    manager = StatusManager();
    statusesStream = manager.getStatusesStream();
    controller = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    User user = authController.currentUser!;
    //return GetX<StatusController>(builder: (statuscontrolador){
    return Column(
      children: [
        Expanded(
          key: const Key("Card"),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: statusesStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                final items = manager.extractStatuses(snapshot.data!);
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    UserStatus status = items[index];
                    return StateCard(
                      //index: index,
                      title: status.title,
                      content: status.message,
                      picUrl: status.picUrl,
                      onDelete: () {
                        if (status.title == "${user.displayName}") {
                          manager.removeStatus(status);
                        } else {
                          Get.snackbar(
                            "Eliminación no Permitida",
                            "No pude eliminar estados que no seam los suyos",
                            icon: const Icon(Icons.person, color: Colors.black),
                            duration: const Duration(seconds: 5),
                            backgroundColor: Colors.red[900],
                          );
                        }
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        FloatingActionButton(
          key: const Key("btn_card"),
          onPressed: () {
              if (controller.connected) {
                Get.dialog(
                  PublishDialog(
                    manager: manager,
                  ),
                );
              } else {
                Get.snackbar(
                  "Error de conectividad",
                  "No se encuentra conectado a internet.",
                );
              }
            },
            child: const Icon(Icons.add),
          )
      ],
    );
    //   return Stack(
    //     children: [
    //       ListView.builder(
    //         itemCount: statuscontrolador.liststados.length,
    //         itemBuilder: (context, index) {
    //           return StateCard(
    //             index: index,
    //             title: statuscontrolador.liststados[index].title,//'Prueba',
    //             content: statuscontrolador.liststados[index].message,//'Lorem ipsum dolor sit amet.',
    //             picUrl: statuscontrolador.liststados[index].picUrl,//'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
    //             onDelete: () => {},
    //           );
    //         },
    //       ),
    //     Positioned(
    //         right: 20,
    //         bottom: 30,
    //         child: FloatingActionButton(
    //           onPressed: () {
    //             Get.dialog(
    //               PublishDialog(manager: manager,)
    //             );
    //           },
    //           child: const Icon(Icons.add),
    //         ))
    //   ],
    // );

    //});
  }
}
