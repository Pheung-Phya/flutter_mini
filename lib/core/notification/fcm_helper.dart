import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void setupFcmListener(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      final title = message.notification!.title ?? '';
      final body = message.notification!.body ?? '';

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$title\n$body')));
    }

    if (message.data['type'] == 'otp') {
      final otp = message.data['otp'];
      // Optional: show OTP in UI or prefill in verify screen if needed
      print('Received OTP via push: $otp');
    }
  });

  // Optional: Handle background/terminated messages
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
    // You can navigate user to OTP screen or elsewhere here if needed
  });
}
