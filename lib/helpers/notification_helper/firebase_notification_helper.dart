part of 'notification_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  await Firebase.initializeApp();
  print('on Message background notification ${message.data}');
  print('on Message background data ${message.notification?.body}');
  print("Handling a background message: ${message.notification!.toMap()}");
}

FirebaseMessaging? _firebaseMessaging;

class FirebaseNotifications {
  static FirebaseNotifications? _instance;

  FirebaseNotifications._internal();

  factory FirebaseNotifications() {
    _instance ??= FirebaseNotifications._internal();
    return _instance!;
  }

  static Future<void> setUpFirebase() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    localNotification();
    firebaseCloudMessagingListeners();
  }

  static getToken() async {
    print("-----------Device Token--------------");
    String? deviceToken = await _firebaseMessaging!.getToken();
    print("-----------Device Token is $deviceToken--------------");

    SharedHelper().writeData(CachingKey.DEVICE_TOKEN, deviceToken);
  }

  static Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();
    getToken();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage data) {
        print('on Message notification ${data.notification?.toMap()}');
        print('on Message data ${data.data}');
        print('on Message body ${data.notification?.body}');
        Map notify = data.data;
        if (Platform.isAndroid) {
          scheduleNotification(data.notification!.title ?? "",
              data.notification!.body ?? "", json.encode(notify));
        }
        updateUserFunctions(notify: notify);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      print('on Opened ${data.data}');
      Map notify = data.data;
      handlePath(notify);
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print("Data from initial message >>>>>> ${value?.data}");
    });

    _notificationsPlugin!.getActiveNotifications().then((value) {
      if (value.isNotEmpty) {
        print('on Opened From ActiveNotifications ${value[0].payload}');
        if (value[0].payload != null && value[0].payload != "") {
          handlePath(
            json.decode(value[0].payload!),
          );
        }
      }
    });

    _notificationsPlugin!
        .getNotificationAppLaunchDetails()
        .then((NotificationAppLaunchDetails? data) {
      print(
          'on Opened From Notification ${json.decode(json.encode(data!.notificationResponse?.payload.toString()))}');
      if (data.notificationResponse?.payload != null &&
          data.notificationResponse?.payload != "") {
        handlePath(json.decode(data.notificationResponse?.payload ?? ""));
      }
    });
  }
}
