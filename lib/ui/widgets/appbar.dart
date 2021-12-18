import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_event/domain/use_cases/controllers/ui.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final bool home;
  final String picUrl;
  final Widget tile;
  final VoidCallback onSignOff;
  final UIController controller;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar(
      {Key? key,
      required this.context,
      required this.controller,
      required this.picUrl,
      required this.tile,
      required this.onSignOff,
      this.home = true})
      : super(
          key: key,
          centerTitle: true,
          leading: Center(
            child: CircleAvatar(
              minRadius: 18.0,
              maxRadius: 18.0,
              backgroundImage: NetworkImage(picUrl),
            ),
          ),
          title: tile,
          actions: [
            IconButton(
              key: const Key("themeAction"),
              icon: Icon(
                controller.darkMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ),
              onPressed: () {
                controller.manager.changeTheme(isDarkMode: !Get.isDarkMode);
                controller.darkMode = !controller.darkMode;
              },
            ),
            IconButton(
              key: const Key("logoutAction"),
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: onSignOff,
            )
          ],
        );
}
