import 'package:buny_app/screens/home_screen.dart';
import 'package:buny_app/screens/registro_producto_screen.dart';
import 'package:flutter/material.dart';

import 'lista_productos_screen.dart';

class MenuWidget extends StatelessWidget {
  String id;

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
                ]
            )
          ],
        )
    );
  }
}