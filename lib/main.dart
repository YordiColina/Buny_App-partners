import 'package:buny_app/registroNegocio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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



  @override
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
          Image.asset('assets/VECIAPP.jpeg',
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
                child: Image.asset('assets/vecilogo.JPG')
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







                ]
            )
          ],
        )
    );
  }
}

