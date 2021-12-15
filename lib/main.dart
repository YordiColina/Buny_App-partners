import 'package:buny_app/registroNegocio.dart';
import 'package:buny_app/screens/lista_productos_screen.dart';
import 'package:buny_app/screens/registro_producto_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan[50],

      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        centerTitle: true,
        title: Text("INICIO"),
      ),

      drawer: menu(),
      body:

      Column(

        children: [
          /*         Center(

                child: Text(
                  'VeciApp',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.brown),


        ),
              ),*/
          Image.network('https://x6i2p6h3.rocketcdn.me/wp-content/uploads/2018/08/selling-3213725_960_720.jpg',
            width: 500,)
        ],
      ),

      /*floatingActionButton:FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>pantalla2( )));
            },
            label: Text('Siguiente'),
            icon:Icon(Icons.arrow_forward_sharp),


        )*/


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


////////////////////////////////////////////////MENU LATERAL ////////////////////////////////////////
class menu extends StatelessWidget {

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
                    title: Text("Inicio"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.note_add,size: 30, color: Colors.cyan[700]),
                    title: Text("Registrarme"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>registroNegocio()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.post_add,size: 30, color: Colors.cyan[700]),
                    title: Text("Agregar producto"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistroProductoScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list,size: 30, color: Colors.cyan[700]),
                    title: Text("Mostrar productos"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ListaProductosScreen()));
                    },
                  ),
                ]
            )
          ],
        )
    );
  }
}
