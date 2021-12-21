import 'package:buny_app/model/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class EditarProductoScreen extends StatefulWidget {
  final String id;
  final String nombre;
  final String precio;
  final String foto;
  final String descripcion;
  final String negocioId;

  const EditarProductoScreen(this.negocioId, this.id, this.nombre, this.descripcion, this.precio, this.foto, {Key? key}) : super(key: key);

  @override
  _EditarProductoScreenState createState() => _EditarProductoScreenState();
}

class _EditarProductoScreenState extends State<EditarProductoScreen> {

  final nombreController = TextEditingController();
  final descripController = TextEditingController();
  final fotoController = TextEditingController();
  final precioController = TextEditingController();

  Future<void> setearInfoProducto(context) async {

      setState(() {
        nombreController.text = widget.nombre;
        descripController.text = widget.descripcion;
        fotoController.text = widget.foto;
        precioController.text = widget.precio;
      });
    }

  Future<void> modificarProducto(context) async {
    /**var productoMap = {
        'nombre': nombreController.text,
        'descripcion' : descripController.text,
        'precio' : precioController.text,
        'foto' : fotoController.text
        };*/

    final instance = FirebaseFirestore.instance;

    var listaJson = [];
    final value = await instance
        .collection("negocios")
        .doc(widget.negocioId)
        .get();
    listaJson = value.data()!["productos"];

    for (int i = 0; i < listaJson.length; i++) {
      if (listaJson[i]['id'] == widget.id) {
        listaJson[i] = {
          'nombre': nombreController.text,
          'descripcion': descripController.text,
          'precio': precioController.text,
          'foto': fotoController.text
        };
      }
    }

    instance
        .collection("negocios")
        .doc(widget.negocioId).update({
      'productos': listaJson
    });

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return HomeScreen(widget.id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    setearInfoProducto(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text("Editar producto"),
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
              onPressed: () => modificarProducto(context),
              child: const Text('Modificar Producto'),
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
