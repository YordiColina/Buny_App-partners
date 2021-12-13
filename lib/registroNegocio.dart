import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
class registroNegocio extends StatefulWidget {
  const registroNegocio({Key? key}) : super(key: key);

  @override
  _registroNegocioState createState() => _registroNegocioState();
}

class _registroNegocioState extends State<registroNegocio> {

    final categoria = TextEditingController();
    final foto = TextEditingController();
    final nombre = TextEditingController();
    final pagina = TextEditingController();
    final rut = TextEditingController();
    final password = TextEditingController();
    final direccion = TextEditingController();
    final telefono = TextEditingController();
    final celular = TextEditingController();
    final correo = TextEditingController();
    List pers = [];
    void limpiar() {
      foto.text = "";
      nombre.text = "";
      pagina.text = "";
      password.text = "";
      rut.text = "";
      direccion.text = "";
      telefono.text = "";
      correo.text = "";
    }

  CollectionReference negocio =FirebaseFirestore.instance.collection('negocios');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text("Registrate"),
          centerTitle: true,
        ),

        drawer: menu(),


        body: ListView(
            children: [
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: foto,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(Icons.sentiment_satisfied_alt,size: 25,color: Colors.cyan[700]),
                        hintText: "Digite el nombre de su Negocio",
                        hintStyle: TextStyle(color: Colors.black38)
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
                        icon: Icon(Icons.sentiment_satisfied_alt,size: 25,color: Colors.cyan[700]),
                        hintText: "Categoria del Negocio",
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                  )
              ),

              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: nombre,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(Icons.sentiment_satisfied_alt,size: 25,color: Colors.cyan[700]),
                        hintText: "Digite el nombre de su Negocio",
                        hintStyle: TextStyle(color: Colors.black38)
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
                        icon: Icon(Icons.spellcheck,size: 25,color: Colors.cyan[700]),
                        hintText: "Introduzca la Url de su pagina",
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: rut,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(Icons.alternate_email,size: 25,color: Colors.cyan[700]),
                        hintText: "Ingrese el numero Rut de su Negocio",
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: password,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(Icons.phone_enabled,size: 25,color: Colors.cyan[700]),
                        hintText: "Ingrese una contraseña",
                        hintStyle: TextStyle(color: Colors.black38)
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
                        icon: Icon(Icons.lock,size: 25,color: Colors.cyan[700]),
                        hintText: "Introduzca su Direccion",
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: telefono,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[700],
                        filled: true,
                        icon: Icon(Icons.lock,size: 25,color: Colors.cyan[700]),
                        hintText: "ingrese el Telefono",
                        hintStyle: TextStyle(color: Colors.black38)
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
                        icon: Icon(Icons.lock,size: 25,color: Colors.cyan[700]),
                        hintText: "Ingrese numero Celular",
                        hintStyle: TextStyle(color: Colors.black38)
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
                        icon: Icon(Icons.lock,size: 25,color: Colors.cyan[700]),
                        hintText: "Ingrese un correo electronico",
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical:10.0,horizontal: 10.0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),


                      ),




                      onPressed: () async {
                        if(foto.text.isEmpty || nombre.text.isEmpty || pagina.text.isEmpty || rut.text.isEmpty || direccion.text.isEmpty|| telefono.text.isEmpty|| password.text.isEmpty ||
                           correo.text.isEmpty || categoria.text.isEmpty || celular.text.isEmpty){
                          print("Campos Vacios");
                          Fluttertoast.showToast(msg: "Campos Vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }else{
                          QuerySnapshot existe = await negocio.where(FieldPath.documentId, isEqualTo: rut.text).get();

                          if(existe.docs.length>0){
                            Fluttertoast.showToast(msg: "El Negocio  ya Existe.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                            limpiar();
                          }else{
                            negocio.doc(rut.text).set({
                              "nombre": nombre.text,
                              "pagina": pagina.text,
                              "direccion": direccion.text,
                              "telefono": telefono.text,
                              "password":password.text,
                              "rut": rut.text,
                              "id":rut.text,
                              "correo":correo.text,
                              "categoria":categoria.text,
                              "celular":celular.text






                            });




                            /* void getCriterio3() async {
                          String respuesta=" ";
                          CollectionReference datos3 = FirebaseFirestore.instance.collection(
                              'negocios');
                          QuerySnapshot negocios3 = await datos3.where(
                              "password", isEqualTo: confirmacion.text).get();
                          if (negocios3.docs.length != 0) {
                            for (var per in negocios3.docs) {
                              print(per.data());
                              setState(() {
                                pers.add(per);
                                respuesta=pers['password'].toString();
                              }
                              );
                            }
                          }
                        }*/

                            QuerySnapshot inserto = await negocio.where(FieldPath.documentId, isEqualTo: rut.text).get();

                            limpiar();
                            if(inserto.docs.length>0){
                              Fluttertoast.showToast(msg: "Se Registo el Negocio Exitosamente.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                            }else{
                              Fluttertoast.showToast(msg: "No se registro el Negocio.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                            }

                          }

                        }
                        setState(() {

                        });
                      },
                      child: Text("Registrar",style: TextStyle(color: Colors.black38, fontSize: 25)),
                    ),
                  ),
                 /* Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical:10.0,horizontal: 10.0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),


                      ),

                      onPressed: () async {
                        if(cedula.text.isEmpty){
                          Fluttertoast.showToast(msg: "Digite la cedula.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                              toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        }else{
                          List lista=[];
                          var id;
                          var ced=cedula.text;
                          QuerySnapshot consulta = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                          if(consulta.docs.length>0){
                            for(var doc in consulta.docs){
                              //id= FieldPath.documentId;
                              lista.add(doc.data());
                            }
                            Fluttertoast.showToast(msg: "Cargando Datos.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                                toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                            cedula.text=ced;
                            nombre.text=lista[0]['nombre'];
                            apellido.text= lista[0]['apellidos'];
                            correo.text= lista[0]['correo'];
                            celular.text= lista[0]['celular'];
                          }
                          else{
                            limpiar();
                            Fluttertoast.showToast(msg: "El Cliente no se encontro.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                                toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                          }
                        }
                      },
                      child: Text("Consultar",style: TextStyle(color: Colors.black38, fontSize: 25)),
                    ),
                 )*/
                ],
              ),
              /*Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty){
                      Fluttertoast.showToast(msg: "Campos Vacios.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      clientes.doc(cedula.text).update({
                        "nombre": nombre.text,
                        "apellidos": apellido.text,
                        "correo": correo.text,
                        "celular": celular.text
                      });
                      limpiar();
                      Fluttertoast.showToast(msg: "Datos Actualizados Correctamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Text("Actualizar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg: "Campos Vacios.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else
                    {
                      clientes.doc(cedula.text).delete();
                      limpiar();
                      Fluttertoast.showToast(msg: "Cliente Eliminado Exitosamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Text("Eliminar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
        },
        child: Icon(Icons.arrow_forward_sharp,size: 30,color: Colors.white),
      ),*/
            ])

    );
  }
}

