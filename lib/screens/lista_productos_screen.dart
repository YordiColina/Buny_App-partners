import 'package:buny_app/model/producto.dart';
import 'package:buny_app/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaProductosScreen extends StatefulWidget {
  final String id;
  const ListaProductosScreen(this.id,{Key? key}) : super(key: key);

  @override
  _ListaProductosScreenState createState() => _ListaProductosScreenState(id);
}

class _ListaProductosScreenState extends State<ListaProductosScreen> {
  _ListaProductosScreenState(this.id);

  String id;
  Future<List<Producto>> getListaProductos() async {
    var listaJson = [];
    final value = await FirebaseFirestore.instance.collection("negocios").doc(id).get();
    listaJson = value.data()!["productos"];

    List<Producto> listaProductos = [];
    for(var item in listaJson){
      listaProductos.add(
          Producto(
              item["nombre"],
              item["descripcion"],
              item["precio"],
              item["foto"]
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
              return ProductItem(productInfo.nombre, productInfo.descripcion, productInfo.precio, productInfo.foto);
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
