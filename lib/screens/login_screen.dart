import 'package:buny_app/screens/home_screen.dart';
import 'package:buny_app/screens/perfil_screen.dart';
import 'package:buny_app/screens/registro_negocio_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  List pers = [];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var negocio =FirebaseFirestore.instance.collection('negocios');

  Future<void> loginIntoAccount(context) async {
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      Fluttertoast.showToast(msg: "Campos Vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
      return;
    }

    await FirebaseFirestore.instance.collection('negocios')
        .where('correo', isEqualTo: emailController.text)
        .where('contrasena', isEqualTo: passwordController.text).get().then((info){
          print(info.toString());

      if(info.docs.isEmpty || info == null){
        Fluttertoast.showToast(msg: "Negocio no encontrado.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
        Fluttertoast.showToast(msg: "Verifique la información ingresada.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
      } else {
        info.docs.forEach((element) {
          String id = element.get("id");
          pers.add(info);
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return HomeScreen(id);
          },),);
        });
      }
    });
  }

  @override

  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Correo"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Contraseña"
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => loginIntoAccount(context),
              child: const Text("Login")),
          TextButton(
              onPressed: () async {



                Navigator.of(context).push(MaterialPageRoute(builder: (_){

                  return  registro_negocio_screen();
                },),);
              },
              child: const Text("Registrar Negocio")),
          TextButton(
              onPressed:  ()  {


                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return HomeScreen("001");

                },),);
              },
              child: const Text("Ingresar como invitado"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.green)
            ),
          ),
        ],
      ),
    );
  }
}



