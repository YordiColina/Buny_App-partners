import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
     class recibiendo_mensaje extends StatefulWidget {
       const recibiendo_mensaje({Key? key}) : super(key: key);

       @override
       _recibiendo_mensajeState createState() => _recibiendo_mensajeState();
     }
     final notificacion1=TextEditingController();
    final notificacion_tittle=TextEditingController();
    String contenido="";
    String titulo="";
     class _recibiendo_mensajeState extends State<recibiendo_mensaje> {
        @override
  void initState() {
          super.initState();


          FirebaseMessaging mensaje = FirebaseMessaging.instance;

          Notificaciones() {
            mensaje.requestPermission();
            mensaje.getToken().then((token) {
              print('-------------token-------------');
              print(token);
            });
          }
        }



        @override

       Widget build(BuildContext context) {
         return Scaffold(
           appBar: AppBar(


           ),

           body: Column(
                children: [
                  TextField( controller:notificacion1 ,style: TextStyle( ) ,),

                  TextField( controller:notificacion_tittle ,style: TextStyle( ) ,),


                ],

           ),


         );
       }
     }



