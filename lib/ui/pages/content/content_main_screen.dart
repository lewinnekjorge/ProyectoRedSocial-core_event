import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:core_event/ui/widgets/appbar.dart';
import 'package:core_event/domain/use_cases/controllers/authentication.dart';
import 'package:core_event/domain/use_cases/controllers/ui.dart';
import 'package:core_event/ui/pages/content/user_feeds/states_screen.dart';
import 'package:core_event/ui/pages/content/public_events/public_events_screen.dart';
import 'package:core_event/ui/pages/content/chat/chat_page.dart';
import 'package:core_event/ui/pages/content/location/location_screen.dart';
import 'package:core_event/ui/pages/content/configuration/conf_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;
  static final List<Widget> _widgets = <Widget>[
    const StatesScreen(),
    const PublicEventsScreen(),
    const ChatScreen(),
    const LocationScreen(),
    const ConfScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final UIController controller = Get.find<UIController>();
    final AuthController authController = Get.find<AuthController>();
    User user = authController.currentUser!;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        controller: controller,
        picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
        tile: Text("Hi ${user.displayName}"),
        onSignOff: () {
          authController.manager.signOut();
        },
      ),
//      body: _widgets.elementAt(_selectedTab),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _widgets.elementAt(_selectedTab),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        activeColor: primaryColor,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_rounded), label: "Estados"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity), label: "Eventos"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Ubicación"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Ajustes"),
        ],
      ),
    );
  }
}
