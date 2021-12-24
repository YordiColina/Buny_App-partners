import 'dart:io';

import 'package:buny_app/model/negocio.dart';
import 'package:buny_app/screens/google_maps_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

import 'menu_widget.dart';


class perfil_screen extends StatefulWidget {
final Negocio negocio;
  const perfil_screen({required this.negocio});

  @override
  _perfil_screenState createState() => _perfil_screenState();
}

class _perfil_screenState extends State<perfil_screen> {

  final nombre=TextEditingController();
  final correo=TextEditingController();
  final contrasena=TextEditingController();
  final categoria=TextEditingController();
  final celular=TextEditingController();
  final direccion=TextEditingController();
  final rut=TextEditingController();
  final telefono=TextEditingController();
  final pagina=TextEditingController();

    var aux;
    var aux2;

//////////////////////////////////////////////////////////////////////////////////////////////
    DocumentReference bunyAppRef = FirebaseFirestore.instance.collection('bunnyApp').doc();

    String camara="";
    String almacen="";
    File? imagen ;
    final picker=ImagePicker();
    Future selimagen(op)async {
      var pickedFile;
      if (op == 1) {
        pickedFile= await picker.pickImage(source: ImageSource.camera);
        camara=pickedFile.toString() ;

      } else {
        pickedFile= await picker.pickImage(source: ImageSource.gallery);
        almacen=pickedFile.toString();
      }
      setState(() {
        if(pickedFile!=null){
          imagen=File(pickedFile.path);

        }else{
          print('No seleccionaste ninguna Foto');

        }
      });
      Navigator.of(context).pop();

      Future<String> uploadFile(File image) async{

        String fileName = image.path;
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('bunyApp/$fileName');
        await storageReference.putFile(image);
        aux2=await storageReference.getDownloadURL();
        return await storageReference.getDownloadURL();
      }


      Future<void> saveImages(File? imagen, DocumentReference ref) async {

        String imageURL = await uploadFile(imagen!);
        ref.update({"images": FieldValue.arrayUnion([imageURL])});


      }
      await saveImages(imagen,bunyAppRef);

    }
  ////////////////////////////////////////////////////////////////////////////////


  opciones(contex) {
    showDialog(context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        selimagen(1);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                                width: 1, color: Colors.grey))
                        ),
                        child: Row(
                          children: [
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
                        selimagen(2);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),

                        child: Row(
                          children: [
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
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.redAccent),
                        child: Row(
                          children: [
                            Expanded(child: Text('Cancelar', style: TextStyle(
                                fontSize: 16, color: Colors.white)
                              ,
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

 //////////////////////////////////////////////////////////////////////////////////////////////
    @override

    Widget build(BuildContext context) {
      nombre.text = widget.negocio.nombre;
      correo.text = widget.negocio.correo;
      contrasena.text = widget.negocio.contrasena;
      categoria.text = widget.negocio.categoria;
      celular.text = widget.negocio.celular;
      direccion.text = widget.negocio.direccion;
      rut.text = widget.negocio.rut;
      telefono.text = widget.negocio.telefono;
      pagina.text = widget.negocio.pagina;
      void limpiar(){
        categoria.text=""; nombre.text=""; rut.text=""; correo.text=""; celular.text=""; contrasena.text=""; telefono.text="";
        pagina.text=""; direccion.text="";
      }
      CollectionReference users =FirebaseFirestore.instance.collection('negocios');

    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text( widget.negocio.nombre),
        ),

      drawer: MenuWidget(widget.negocio.id),

        body: ListView(
            children: [

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 137.0, right: 15.0, bottom: 10.0,top:10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.negocio.foto_perfil),
                      radius: 70,
                    ),
                  )
                ],
              ),

              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ElevatedButton(onPressed:(){

                      opciones(context );

                    }
                        , child: Text('Cambiar Foto de Perfil')
                    ),
                    SizedBox(height: 30,),
                    imagen==null?Center() : Image.file(imagen!),
                  ],

                ),

              ),
        Container(
        padding: EdgeInsets.all(20.0),
        child: TextField(
          controller: nombre,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              fillColor: Colors.cyan[700],
              filled: true,
              icon: Icon(
                  Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
              hintText: "Nombre",
              hintStyle: TextStyle(color: Colors.black12)
          ),
        )
    ),
    Container(
    padding: EdgeInsets.all(20.0),
    child: TextField(
    controller: correo,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
    fillColor: Colors.cyan[700],
    filled: true,
    icon: Icon(
    Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
    hintText: "Correo",
    hintStyle: TextStyle(color: Colors.black12)
    ),
    )
    ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: contrasena,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(
                            Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
                        hintText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.black12)
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: categoria,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(
                            Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
                        hintText: "Categoria",
                        hintStyle: TextStyle(color: Colors.black12)
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: celular,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(
                            Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
                        hintText: "Celular",
                        hintStyle: TextStyle(color: Colors.black12)
                    ),
                  )
              ),
              Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: direccion,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.cyan[700],
                  filled: true,
                  icon: InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return GoogleMapsWidget(widget.negocio);
                    })),
                    child: Icon(Icons.location_on,
                        size: 25, color: Colors.cyan[700]),
                  ),
                  hintText: "Direccion",
                  hintStyle: TextStyle(color: Colors.black12)),
            )),
        Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: rut,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.cyan[700],
                  filled: true,
                  icon: Icon(Icons.drag_indicator,
                      size: 25, color: Colors.cyan[700]),
                  hintText: "Rut",
                  hintStyle: TextStyle(color: Colors.black12)),
            )),
        Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: telefono,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(
                            Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
                        hintText: "Telefono",
                        hintStyle: TextStyle(color: Colors.black12)
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: pagina,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(
                            Icons.drag_indicator, size: 25, color: Colors.cyan[700]),
                        hintText: "Pagina",
                        hintStyle: TextStyle(color: Colors.black12)
                    ),
                  )
              ),
              Row(
                children: [Container(
                  padding: EdgeInsets.only(left: 55.0, right: 0.0, bottom: 20.0),
                  alignment: Alignment.center,
                  child: ElevatedButton(

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical:10.0,horizontal: 10.0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: ()async {
                        QuerySnapshot existe2 = await users.where(FieldPath.documentId, isEqualTo: rut.text).get();
                        if(rut.text.isEmpty || nombre.text.isEmpty || categoria.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty||
                            telefono.text.isEmpty || pagina.text.isEmpty || direccion.text.isEmpty || contrasena.text.isEmpty ){
                          Fluttertoast.showToast(msg: "Campos Vacios.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                              toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        }else{
                          List<Location> locations = await locationFromAddress(direccion.text);
                          var location = locations[0];
                          users.doc(rut.text).update({
                            "nombre": nombre.text,
                            "categoria": categoria.text,
                            "correo": correo.text,
                            "celular": celular.text,
                            "contrasena":contrasena.text,
                            "pagina":pagina.text,
                            "rut": rut.text,
                            "direccion":direccion.text,
                            "telefono":telefono.text,
                            "foto_perfil":aux2.toString(),
                            "geolocalizacion": GeoPoint(
                                  location.latitude,
                                  location.longitude
                            ),
                          });

                          Fluttertoast.showToast(msg: "Datos Actualizados Correctamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                              toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        }
                      },
                      child: Text("Actualizar datos")),
                ),


                  Container(
                    padding: EdgeInsets.only(left: 50.0, right: 0.0, bottom: 20.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: ()  {
                          if(rut.text.isEmpty){
                            Fluttertoast.showToast(msg: "Campos Vacios.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                                toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                          }else
                          {
                            users.doc(rut.text).delete();
                            limpiar();
                            Fluttertoast.showToast(msg: "Usuario Eliminado Exitosamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                                toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                          }
                        }, child: Text("Dar de baja usuario")),
                  )
                ], ),
    ]),
    );
  }
}
