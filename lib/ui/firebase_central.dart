import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:core_event/ui/pages/content/content_main_screen.dart';
import 'package:core_event/ui/pages/content_start.dart';

class FirebaseCentral extends StatelessWidget {
  const FirebaseCentral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const FeedScreen();
        } else {
          return const InicioWidget(
            title: 'Main',
          );
        }
      },
    );
  }
}
