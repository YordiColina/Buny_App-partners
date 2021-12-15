import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String nombre;
  String precio;
  String foto;
  String descripcion;

  ProductItem(this.nombre, this.descripcion, this.precio, this.foto);



  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        margin: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.cyan[700],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
              children: [
                Image.network(foto),
                Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.cyan[700],
                    child: Text(nombre + "\n " + precio +"\n" + descripcion,style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center)

                )
              ]
          ),
        )
    );
  }
}
