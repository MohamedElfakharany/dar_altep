import 'dart:io';
import 'package:dar_altep/models/notification_model.dart';
import 'package:dar_altep/screens/home/components/widet_components.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dar_altep/shared/components/general_components.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final List<MessageModel> message = [];
  // @override
  // void initState() async {
  //
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     print('onMessage.listen: $notification');
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("onMessageOpenedApp: $message");
  //   });
  //
  //   if (Platform.isIOS) {
  //     firebaseMessaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );
  //   }
  //
  //   firebaseMessaging.requestPermission();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(title: 'Notifications'),
      // body: ListView(
      //   children: message.map(BuildMessage).toList(),
      // ),
    );
  }
}
