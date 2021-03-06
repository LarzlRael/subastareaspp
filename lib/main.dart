import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:subastareaspp/provider/filter_provider.dart';
import 'package:subastareaspp/routes/routes.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/utils/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  /* FirebaseMessaging messaging = FirebaseMessaging.instance; */

  /* NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  final prefs = UserPreferences();
  await prefs.initPrefs();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      ); */

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    /* FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      showSnackBar(message.data['type_notification'], message.data['content']);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    }); */
    PushNotificationService.messageStream.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: $message');
      /* showSnackBar(message); */
    });
  }

  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        title: 'Subastareas',
        scaffoldMessengerKey: _messangerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: appRoutes,
        initialRoute: 'loading',
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
          Locale('fr', ''),
          Locale('ja', ''),
          Locale('pt', ''),
        ],
      ),
    );
  }

  showSnackBar(String type, String message) {
    _messangerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: type == "comment" ? Colors.green : Colors.blue,
      ),
    );
  }
}
