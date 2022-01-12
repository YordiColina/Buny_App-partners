import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/producto.dart';
import 'home_screen.dart';

class RegistroProductoScreen extends StatefulWidget {
  final String id;

  RegistroProductoScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<RegistroProductoScreen> createState() => _RegistroProductoScreenState();
}

class _RegistroProductoScreenState extends State<RegistroProductoScreen> {
  var aux;
  var aux2;
  DocumentReference bunyAppRef = FirebaseFirestore.instance.collection(
      'bunnyApp').doc();
  String camara = "";
  String almacen = "";
  File? imagen;
  String imgUrl = "";
  final picker = ImagePicker();
  final nombreController = TextEditingController();
  final descripController = TextEditingController();
  final precioController = TextEditingController();

  Future<void> registarProducto(context) async {
    Producto newProducto = Producto(
        id: DateTime.now().toString(),
        nombre: nombreController.text,
        descripcion: descripController.text,
        precio: precioController.text,
        foto: imgUrl
    );

    var productoMap = {
      'id': newProducto.id,
      'nombre': newProducto.nombre,
      'descripcion': newProducto.descripcion,
      'precio': newProducto.precio,
      'foto': newProducto.foto
    };
    FirebaseFirestore.instance
        .collection("negocios").doc(widget.id).update({
      'productos': FieldValue.arrayUnion([productoMap])
    });

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return HomeScreen(widget.id);
    }));
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
                              'Tomar una Foto', style: TextStyle(fontSize: 16),
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
      camara = pickedFile.toString();
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      almacen = pickedFile.toString();
    }
    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print('No seleccionaste ninguna Foto');
      }
    });

    Navigator.of(context).pop();
    Future<String> uploadFile(File image) async {
      String fileName = image.path;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('bunyAppProducts/$fileName');
      await storageReference.putFile(image);
      aux2 = await storageReference.getDownloadURL();
      return aux2;
    }



        Future<void> saveImages(File? imagen, DocumentReference ref) async {
        imgUrl = await uploadFile(imagen!);
      //String imageURL = await uploadFile(imagen!);
        //ref.update({"images": FieldValue.arrayUnion([imageURL])});
        }
        await saveImages(imagen, bunyAppRef);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text("Agregar producto"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ElevatedButton(onPressed: () {
                      opciones(context);
                    }
                        , child: const Text('seleccione una imagen')
                    ),
                    const SizedBox(height: 30,),
                    imagen == null ? const Center() : Image.file(imagen!),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => registarProducto(context),
                child: const Text('Registrar Producto'),
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