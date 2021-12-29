import 'package:buny_app/model/negocio.dart';
import 'package:buny_app/screens/home_screen.dart';
import 'package:buny_app/screens/perfil_screen.dart';
import 'package:buny_app/screens/recibiendo_mensaje.dart';
import 'package:buny_app/screens/registro_producto_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'lista_productos_screen.dart';

class MenuWidget extends StatelessWidget {
  String id;

  CollectionReference users =FirebaseFirestore.instance.collection('negocios');
  List usuarios = [];
  MenuWidget(this.id, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.cyan[700]
                ),
                child: Image.network('https://x6i2p6h3.rocketcdn.me/wp-content/uploads/2018/08/selling-3213725_960_720.jpg')
            ),
            Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.home, size: 30, color: Colors.cyan[700]),
                    title: const Text("Inicio"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(id)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.account_box_outlined, size: 30, color: Colors.cyan[700]),
                    title: const Text("Perfil"),
                    onTap: () async {
                      QuerySnapshot existe = await users.where(
                          FieldPath.documentId, isEqualTo: id).get();


                      if (existe.docs.length !=
                          0) { // lo recorremos y guardamos en un arreglo
                        for (var per in existe.docs) {
                           print(per.data());

                          usuarios.add(per);
                        }
                      }
                     Negocio Url = Negocio(usuarios[0]['nombre'],usuarios[0]['correo'], usuarios[0]['contrasena'], usuarios[0]['foto_perfil'],
                       usuarios[0]['categoria'],usuarios[0]['celular'], usuarios[0]['direccion'], usuarios[0]['rut'],usuarios[0]['telefono'],usuarios[0]['pagina'],usuarios[0]['id']);



                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              perfil_screen(negocio: Url)));
                    },

                     ),

                  ListTile(
                    leading: Icon(Icons.post_add,size: 30, color: Colors.cyan[700]),
                    title: const Text("Agregar producto"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistroProductoScreen(id)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list,size: 30, color: Colors.cyan[700]),
                    title: const Text("Mostrar productos"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ListaProductosScreen(id)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.drafts,size: 30, color: Colors.cyan[700]),
                    title: const Text("Notificaciones"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>recibiendo_mensaje()));
                    },
                  ),
                ]
            )
          ],
        )
    );
  }
}

