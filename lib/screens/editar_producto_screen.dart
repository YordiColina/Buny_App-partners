import 'dart:io';

import 'package:buny_app/model/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String? imgUrl;
  DocumentReference bunyAppRef = FirebaseFirestore.instance.collection(
      'bunnyApp').doc();
  String camara = "";
  String almacen = "";
  File? imagen;
  final picker = ImagePicker();

  final nombreController = TextEditingController();
  final descripController = TextEditingController();
  final precioController = TextEditingController();

  Future<void> setearInfoProducto(context) async {

      setState(() {
        nombreController.text = widget.nombre;
        descripController.text = widget.descripcion;
        precioController.text = widget.precio;
      });
    }

  Future<void> modificarProducto(context) async {
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
          'id':widget.id,
          'nombre': nombreController.text,
          'descripcion': descripController.text,
          'precio': precioController.text,
          'foto': imgUrl,
        };
      }
    }

    instance
        .collection("negocios")
        .doc(widget.negocioId).update({
      'productos': listaJson
    });

    Navigator.of(context).pop();
  }

  opciones(context) {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        selImagen(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(
                                width: 1, color: Colors.grey))
                        ),
                        child: Row(
                          children: const [
                            Expanded(child: Text(
                              'Tomar una Foto', style: TextStyle(fontSize: 16)
                              ,
                            ),
                            ),
                            Icon(Icons.camera_alt, color: Colors.blue)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selImagen(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),

                        child: Row(
                          children: const [
                            Expanded(child: Text('Seleccionar una Foto',
                              style: TextStyle(fontSize: 16)
                              ,

                            ),

                            ),
                            Icon(Icons.image, color: Colors.blue)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.redAccent),
                        child: Row(
                          children: const [
                            Expanded(child: Text('Cancelar', style: TextStyle(
                                fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
              ),
            ),
          );
        }
    );
  }

  Future selImagen(op) async {
    XFile? pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print('No seleccionaste ninguna Foto');
      }
    });


    Future<String> uploadFile(File image) async {
      String fileName = image.path;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('bunyAppProducts/$fileName');
      await storageReference.putFile(image);

      return await storageReference.getDownloadURL();
    }

    Future<void> saveImages(File? imagen, DocumentReference ref) async {
        imgUrl = await uploadFile(imagen!);
      //String imageURL = await uploadFile(imagen!);
      //ref.update({"images": FieldValue.arrayUnion([imageURL])});
    }

    await saveImages(imagen, bunyAppRef).then((value) => Navigator.of(context).pop());
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
              child: imagen == null
            ?InkWell(
                  child: Image.network(widget.foto),
                  onTap: () => opciones(context),
            )
            :InkWell(
                child: Image.file(imagen!),
                onTap: () => opciones(context),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
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
                style: const TextStyle(
                  color: Colors.black,
                ),
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
                style: const TextStyle(
                  color: Colors.black,
                ),
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
