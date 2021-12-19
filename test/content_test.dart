import 'package:core_event/core/initialize.dart';
import 'package:core_event/data/services/event_pool.dart';
import 'package:core_event/data/services/location.dart';
import 'package:core_event/domain/controller/authentication_controller.dart';
import 'package:core_event/domain/controller/chat_controller.dart';
import 'package:core_event/domain/controller/newstatus.dart';
import 'package:core_event/domain/use_cases/controllers/authentication.dart';
import 'package:core_event/domain/use_cases/controllers/connectivity.dart';
import 'package:core_event/domain/use_cases/controllers/location.dart';
import 'package:core_event/domain/use_cases/controllers/notifications.dart';
import 'package:core_event/domain/use_cases/controllers/permissions.dart';
import 'package:core_event/domain/use_cases/controllers/ui.dart';
import 'package:core_event/domain/use_cases/location_management.dart';
import 'package:core_event/ui/pages/content/content_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockUser extends Mock implements User {}

final MockUser mockUser = MockUser();

class MockLocation extends Mock implements LocationController{}

final LocationController locationController = LocationController();

void main() {

  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized()
          as TestWidgetsFlutterBinding;

  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;
    Get.put(UIController());
    Get.put(AuthController());
    Get.put(StatusController());
    Get.put(ConnectivityController());
    Get.put(EventPoolService());
    /*Future<List<EventModel>> futureEvents;
    EventPoolService service;
    service = EventPoolService();
    futureEvents = service.fecthData();*/
    AuthController authController = Get.find<AuthController>();
    authController.currentUser = mockUser;
    Get.put(ChatController());
    Get.put(AuthenticationController());
    Get.put(PermissionsController());
    Get.put(LocationController());
    Get.put(NotificationController());
    Get.put(LocationManager());
    Get.put(LocationService());

  });
  testWidgets("states-screen", (WidgetTester tester) async {
  
    // Widgets Testing requires that the widgets we need to test have a unique key
    final section = find.byKey(const ValueKey("statesSection"));
    final card = find.byKey(const ValueKey("Card"));
    final btnCard = find.byKey(const ValueKey("btn_card"));
    final cardField = find.byKey(const ValueKey("cardField"));
    final publicar = find.byKey(const ValueKey("publicar"));

    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: FeedScreen()));
      await tester.pump();
      await tester.tap(section);
      /*await tester.pump();
      await tester.tap(btnCard);
      await tester.pump();
      await tester.enterText(cardField, "Prueba de estado");
      await tester.tap(publicar);*/
      await tester.pump();

      expect(card, findsWidgets);
    });
  });

  testWidgets("chat-screen", (WidgetTester tester) async {
  
    // Widgets Testing requires that the widgets we need to test have a unique key
    final chat = find.byKey(const ValueKey("chat"));
    final mensaje = find.byKey(const ValueKey("mensaje"));
    final chatField = find.byKey(const ValueKey("chatField"));
    final sendButton = find.byKey(const ValueKey("sendButton"));
    //final mensajeEspec = find.text("Prueba de chat");
    
    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: FeedScreen()));
      await tester.pump();
      await tester.tap(chat);
      await tester.pumpAndSettle();
      await tester.enterText(chatField, "Prueba de chat");
      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      //expect(mensajeEspec, findsOneWidget);
      expect(mensaje, findsWidgets);
    });
  });

  testWidgets("wrong-screen", (WidgetTester tester) async {
  
    // Widgets Testing requires that the widgets we need to test have a unique key
    final conf = find.byKey(const ValueKey("chat"));
    final card = find.byKey(const ValueKey("Card"));
    //final prefs = find.text("Escoge tus preferencias");
    //final int = find.byKey(const ValueKey("int"));
    
    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: FeedScreen()));
      await tester.pump();
      await tester.tap(conf);
      await tester.pumpAndSettle();
      //await tester.enterText(int, "5");
      //await tester.pumpAndSettle();

      //expect(mensajeEspec, findsOneWidget);
      expect(card, findsNothing);
    });
  });

}