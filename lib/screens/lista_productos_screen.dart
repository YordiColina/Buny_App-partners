import 'package:buny_app/model/producto.dart';
import 'package:buny_app/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaProductosScreen extends StatefulWidget {
  const ListaProductosScreen({Key? key}) : super(key: key);

  @override
  _ListaProductosScreenState createState() => _ListaProductosScreenState();
}

class _ListaProductosScreenState extends State<ListaProductosScreen> {
  
  Future<List<Producto>> getListaProductos() async {
    var listaJson = [];
    final value = await FirebaseFirestore.instance.collection("negocios").doc('001').get();
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
        title: Text("Productos"),
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
            /**return GridView(
              padding: const EdgeInsets.all(5),
              children: (snapshot.data!)
                  .map((productInfo){
                return ProductItem(productInfo.nombre, productInfo.descripcion, productInfo.precio, productInfo.foto);
              }).toList(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6
              ),
            );*/
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
