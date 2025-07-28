import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mini/bloc/auth/auth_bloc.dart';
import 'package:flutter_mini/bloc/cart/bloc/cart_bloc.dart';
import 'package:flutter_mini/bloc/product/bloc/product_bloc.dart';
import 'package:flutter_mini/core/notification/fcm_helper.dart';
import 'package:flutter_mini/firebase_options.dart';
import 'package:flutter_mini/locator.dart';
import 'package:flutter_mini/presentation/authpages/otp_screen.dart';
import 'package:flutter_mini/presentation/authpages/register_page.dart';
import 'package:flutter_mini/presentation/product_pages/home_page.dart';
import 'package:flutter_mini/presentation/authpages/login_page.dart';
import 'package:flutter_mini/presentation/authpages/splash_page.dart';
import 'package:flutter_mini/presentation/menus/menu_page.dart';
import 'package:flutter_mini/presentation/product_pages/product_detail.dart';
import 'package:flutter_mini/presentation/profile_page/change_password_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// This must be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("🔙 Background Message: ${message.notification?.title}");
  _showNotification(message.notification?.title, message.notification?.body);
}

Future<void> _initLocalNotifications() async {
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

void _showNotification(String? title, String? body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(0, title, body, platformDetails);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.subscribeToTopic('all');
  await _initLocalNotifications();

  // Handle foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log("📲 Foreground Message: ${message.notification?.title}");
    if (message.notification != null) {
      _showNotification(
        message.notification?.title,
        message.notification?.body,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log("🔔 Notification Clicked!");
  });
  runApp(const MyApp());

  log('hhhhhhhhhhhhhhhhhhhh = ${await FirebaseMessaging.instance.getToken()}');
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navigatorKey.currentContext != null) {
        setupFcmListener(navigatorKey.currentContext!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<ProductBloc>(
          create: (_) {
            final bloc = sl<ProductBloc>();
            Future.microtask(() => bloc.add(GetAllProducts()));
            return bloc;
          },
        ),
        BlocProvider<CartBloc>(create: (_) => sl<CartBloc>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, // <-- Required for FCM to work with context
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const SplashPage());

            case '/menu':
              return MaterialPageRoute(builder: (_) => MenuPage());

            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());

            case '/register':
              return MaterialPageRoute(builder: (_) => const RegisterScreen());

            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());

            case '/change-password':
              return MaterialPageRoute(builder: (_) => ChangePasswordPage());

            case '/product-detail':
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => ProductDetail(id: id));
            case '/otp':
              final args = settings.arguments as Map<String, String>;
              return MaterialPageRoute(
                builder:
                    (_) => OtpScreen(
                      name: args['name']!,
                      email: args['email']!,
                      password: args['password']!,
                      passwordConfirmation: args['passwordConfirmation']!,
                    ),
              );

            default:
              return MaterialPageRoute(
                builder:
                    (_) => Scaffold(
                      body: Center(
                        child: Text('No route defined for ${settings.name}'),
                      ),
                    ),
              );
          }
        },
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print("Background Message: ${message.notification?.title}");
// }

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   await initNotifications();

//   runApp(MyApp());
// }

// Future<void> initNotifications() async {
//   const AndroidInitializationSettings androidInitSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initSettings = InitializationSettings(
//     android: androidInitSettings,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initSettings);

//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   print("User granted permission: ${settings.authorizationStatus}");

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Foreground Message: ${message.notification?.title}");
//     if (message.notification != null) {
//       showNotification(message.notification?.title, message.notification?.body);
//     }
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print("Notification Clicked!");
//   });

//   String? token = await messaging.getToken();
//   log("FCM Token: $token");
// }

// void showNotification(String? title, String? body) async {
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const NotificationDetails notificationDetails = NotificationDetails(
//     android: androidDetails,
//   );
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     notificationDetails,
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("FCM Notifications")),
//         body: const Center(child: Text("Listening for notifications...")),
//       ),
//     );
//   }
// }
