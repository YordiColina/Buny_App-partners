import 'package:buny_app/screens/editar_producto_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String nombre;
  String precio;
  String foto;
  String descripcion;
  String id;
  String negocioId;

  ProductItem(this.negocioId, this.id, this.nombre, this.descripcion, this.precio, this.foto);



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return EditarProductoScreen(negocioId, id, nombre, descripcion, precio, foto);
        }));
      },
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          margin: const EdgeInsets.all(20),
          elevation: 10,
          color: Colors.cyan[700],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Column(
                children: [
                  Image.network(foto),
                  Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.cyan[700],
                      child: Text(nombre + "\n " + precio +"\n" + descripcion,style: const TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center)

                  )
                ]
            ),
          )
      ),
    );
  }
}