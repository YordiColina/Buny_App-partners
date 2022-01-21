import 'package:buny_app/screens/login_screen.dart';
import 'package:buny_app/screens/recibiendo_mensaje.dart';
import 'package:buny_app/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'config/themes.dart';

FirebaseMessaging mensaje=FirebaseMessaging.instance;
// handler para manejar notificaciones en segundo plano y con la app cerrada
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkTheme(context),
      home: LoginScreen(),
      routes:{
        "enviar": (_)=> recibiendo_mensaje(),
      }
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(


    );
  }
}
