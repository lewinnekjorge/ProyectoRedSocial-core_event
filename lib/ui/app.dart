import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_event/domain/controller/authentication_controller.dart';
import 'package:core_event/domain/controller/chat_controller.dart';
import 'package:core_event/domain/use_cases/controllers/connectivity.dart';
import 'package:core_event/domain/use_cases/controllers/ui.dart';
import 'package:core_event/domain/use_cases/theme_management.dart';
import 'package:core_event/domain/use_cases/controllers/permissions.dart';
import 'package:core_event/domain/use_cases/permission_management.dart';
import 'package:core_event/domain/use_cases/controllers/location.dart';
import 'package:core_event/domain/use_cases/controllers/notification.dart';
import 'package:core_event/domain/use_cases/auth_management.dart';
import 'package:core_event/domain/use_cases/controllers/authentication.dart';
import 'package:core_event/domain/repositories/auth.dart';
import 'package:core_event/data/repositories/password_auth.dart';
import 'firebase_central.dart';
import 'package:core_event/ui/theme/theme.dart';
import 'package:core_event/ui/pages/content_start.dart';
import 'package:core_event/ui/pages/authentication/usr_login.dart';
import 'package:core_event/ui/pages/authentication/usr_register.dart';
import 'package:core_event/ui/pages/content/content_main_screen.dart';
import 'package:core_event/domain/controller/newstatus.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // The future is part of the state of our widget. We should not call `initializeApp`
  // directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _stateManagementInit();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          Get.snackbar(
            "Problemas con FireBase",
            "Verifique sus firebase",
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          _firebaseStateInit();
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Core Event v2',
            //theme: ThemeData(primarySwatch: Colors.black),
            theme: MyTheme.ligthTheme,
            // Establecemos el tema oscuro
            darkTheme: MyTheme.darkTheme,
            // Por defecto tomara la seleccion del sistema
            themeMode: ThemeMode.system,
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => const InicioWidget(
                    title: 'Main',
                  ),
              '/usr_login': (context) => const LoginWidget(
                    title: 'Login',
                  ),
              '/usr_register': (context) => const RegisterWidget(
                    title: 'Registro',
                  ),
              '/feed_screen': (context) => const FeedScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
          home: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void _stateManagementInit() {
    // Dependency Injection
    UIController uiController = Get.put(UIController());
    uiController.themeManager = ThemeManager();

    // Reactive
    ever(uiController.reactiveBrightness, (bool isDarkMode) {
      uiController.manager.changeTheme(isDarkMode: isDarkMode);
    });

    // Permition COntroller
    PermissionsController permissionsController =
        Get.put(PermissionsController());
    permissionsController.permissionManager = PermissionManager();

    // Auth Controller
    AuthController authController = Get.put(AuthController());

    // State management: listening for changes on using the reactive var
    ever(authController.reactiveAuth, (bool authenticated) {
      // Using Get.off so we can't go back when auth changes
      // This navigation triggers automatically when auth state changes on the app state
      if (authenticated) {
        Get.offNamed('/feed_screen');
      } else {
        Get.offNamed('/');
      }
    });
    // Connectivity Controller
    ConnectivityController connectivityController =
        Get.put(ConnectivityController());
    // Connectivity stream
    Connectivity().onConnectivityChanged.listen((connectivityStatus) {
      //log("connection changed");
      connectivityController.connectivity = connectivityStatus;
    });
    // Location Controller
    Get.put(LocationController());
    // Notification controller
    NotificationController notificationController =
        Get.put(NotificationController());
    notificationController.initialize();
  }

  _firebaseStateInit() {
    AuthController authController = Get.find<AuthController>();
    // Setting manager
    authController.authManagement = AuthManagement(
      auth: PasswordAuth(),
    );
    // Watching auth state changes
    AuthInterface.authStream.listen(
      (user) => authController.currentUser = user,
    );
    Get.put(AuthenticationController());
    Get.put(ChatController());
    Get.put(StatusController());

    return const FirebaseCentral();
  }
}
