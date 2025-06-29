import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsSettings{

  late final apnsToken;
  late final fcmToken;

  Future<void> initPermissions() async {

    Future.wait([

      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
        ),

      apnsToken = FirebaseMessaging.instance.getAPNSToken(),


    fcmToken =  FirebaseMessaging.instance.getToken(vapidKey: "BHx8ktjYdhMj-ssSMcvIfF5IMO-h4UXzkhS8FTQLDtPw7zaiK0nd7_FXX0Xe-hVmt2YyFQ49W-_Hvd6xrgJXkYo")
    ]);
  }
}