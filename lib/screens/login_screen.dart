import 'package:buny_app/screens/home_screen.dart';
import 'package:buny_app/screens/recibiendo_mensaje.dart';
import 'package:buny_app/screens/registro_negocio_screen.dart';
import 'package:buny_app/services/local_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

FirebaseMessaging mensaje=FirebaseMessaging.instance;
// handler para manejar notificaciones en segundo plano y con la app cerrada
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    LocalNotificationService.initialize(context);
    // TODO: implement initState
    super.initState();
    // onMessage es para cuando la app este en primer plano

    FirebaseMessaging.onMessage.listen(( message) {
      if(message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
        LocalNotificationService.Display(message);
      }
    });

    // cuando la app este abierta pero en segundo plano y permite modificar el ontap de la notificacion
    FirebaseMessaging.onMessageOpenedApp.listen(( message) {
      if(message.notification != null) {
        contenido = message.notification!.body!;

        titulo = message.notification!.title!;

        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
        print(routeFromMessage);

      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message!=null) {
        contenido = message.notification!.body!;

        titulo = message.notification!.title!;

        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
        print(routeFromMessage);
      }
    }); // cuando la app esta cerrada , recibe el mensaje
    //o la info de la notificacion tocada por el usuario


    //funcion  que maneja los mensajes cuando la app esta en estado terminada(cerrada)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  }
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var negocio = FirebaseFirestore.instance.collection('negocios');

  Future<void> loginIntoAccount(context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Campos Vacios",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    await FirebaseFirestore.instance
        .collection('negocios')
        .where('correo', isEqualTo: emailController.text)
        .where('contrasena', isEqualTo: passwordController.text)
        .get()
        .then((info) {
      if (info.docs.isEmpty) {
        Fluttertoast.showToast(
            msg: "Negocio no encontrado.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
        Fluttertoast.showToast(
            msg: "Verifique la información ingresada.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      } else {
        for (var element in info.docs) {
          String id = element.get("id");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return HomeScreen(id);
              },
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double safeHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      body: ListView(
        children:[ Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              SizedBox(
                height: safeHeight * 0.25,
                width: mediaQuery.size.width,
                child: Image.asset(
                  'lib/assets/images/night_sky.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: mediaQuery.size.width * 0.3,
                child: ClipOval(
                  child: SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        'lib/assets/images/Raster.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: safeHeight * 0.020,
            ),
            const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: safeHeight * 0.020,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  fillColor: Color(0xff696969),
                  filled: true,
                  hintText: 'Ingresa tu correo',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xffe7e7e7),
                  ),
                  prefixIcon: Icon(Icons.mail),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: safeHeight * 0.020,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  fillColor: Color(0xff696969),
                  filled: true,
                  hintText: 'Ingresa tu contraseña',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xffe7e7e7),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: safeHeight * 0.020,
            ),
            ElevatedButton(
                onPressed: () => loginIntoAccount(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    "Ingresar",
                    style: TextStyle(fontSize: 18, color: Color(0xffC5D2DC)),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff2A74A5)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )))),
            SizedBox(
              height: safeHeight * 0.3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Aún no tienes cuenta?',
                  style: TextStyle(color: Color(0xffE1E3E5), fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return const RegistroNegocioScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Registrate",
                      style: TextStyle(color: Color(0xffC4BB0A), fontSize: 20),
                    )),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return HomeScreen("001");
                    },
                  ),
                );
              },
              child: const Text(
                "Ingresar como invitado",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(const Color(0xffC4BB0A))),
            ),
          ],
        ),
     ] ),
    );
  }
}


