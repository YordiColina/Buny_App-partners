import 'package:buny_app/model/producto.dart';
import 'package:buny_app/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListaProductosScreen extends StatefulWidget {
  final String id;
  const ListaProductosScreen(this.id,{Key? key}) : super(key: key);

  @override
  _ListaProductosScreenState createState() => _ListaProductosScreenState();
}

class _ListaProductosScreenState extends State<ListaProductosScreen> {

  DocumentSnapshot<Map<String, dynamic>>? value;
  Future<List<Producto>> getListaProductos() async {
    var listaJson = [];
     await FirebaseFirestore.instance.collection("negocios").doc(widget.id).get()
        .then((value){
          if(value.data() == null){

          }
      listaJson = value.data()!["productos"];
    }).onError((error, stackTrace){
      Fluttertoast.showToast(msg: error.toString(), toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    });

    List<Producto> listaProductos = [];
    for(var item in listaJson){
      listaProductos.add(
          Producto(
            id: item['id'],
            nombre:item["nombre"],
            descripcion:item["descripcion"],
            precio:item["precio"],
            foto:item["foto"],
          )
      );
    }
    return listaProductos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: const Text("Productos"),
          centerTitle: true,
        ),
        body: Container(
          child: FutureBuilder(
            future: getListaProductos(),
            builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
              if(snapshot.hasError){
                return Center(
                    child: Text(snapshot.error.toString())
                );
              } else if (snapshot.hasData){
                var list = (snapshot.data!)
                    .map((productInfo){
                  return ProductItem(widget.id, productInfo.id, productInfo.nombre, productInfo.descripcion, productInfo.precio, productInfo.foto);
                }).toList();
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, int index){
                    return list[index];
                  },
                );
              } else{
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
            },

          ),
        )
    );
  }
}