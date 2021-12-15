import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../model/producto.dart';

class RegistroProductoScreen extends StatelessWidget {

  final nombreController = TextEditingController();
  final descripController = TextEditingController();
  final fotoController = TextEditingController();
  final precioController = TextEditingController();

  //CollectionReference negocio = FirebaseFirestore.instance.collection('negocios')
   //   .where('id', isEqualTo: '001').get() as CollectionReference<Object?>;

  Future<void> registarProducto() async {
    Producto newProducto = Producto(nombreController.text, descripController.text, fotoController.text, precioController.text);

    var productoMap = {
      'nombre': newProducto.nombre,
      'descripcion' : newProducto.descripcion,
      'precio' : newProducto.precio,
      'foto' : newProducto.foto
    };
    FirebaseFirestore.instance
        .collection("negocios").doc('001').update({
      'productos': FieldValue.arrayUnion([productoMap])
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text("Registrate"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Nombre',
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                      ),
                    ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Precio',
                    prefixIcon: Icon(Icons.price_change),
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descripController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Descripción',
                    prefixIcon: Icon(Icons.description),
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: fotoController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Foto',
                    prefixIcon: Icon(Icons.add_a_photo),
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: registarProducto,
                child: Text('Registrar Producto'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan[700])
                ),
            )
          ],
        ),
      ),
    );
  }
}
