import 'package:flutter/material.dart';

import 'menu_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.id, {
    Key? key,
  }) : super(key: key);
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],

      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        centerTitle: true,
        title: const Text("INICIO"),
      ),

      drawer: MenuWidget(id),
      body: Column(
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
