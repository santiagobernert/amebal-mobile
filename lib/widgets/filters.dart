import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Filters extends StatefulWidget {
  Function callback;
  Filters(this.callback, {Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  late Future<List<String>> categorias;
  late Future<List<String>> torneos;
  late String categoria;
  late String sexo;
  String torneo='Handball Super Cup 2029';

  void change(torneo, categoria, sexo){
    widget.callback(torneo, categoria, sexo);
  }
 //fetching categories from API
  Future<List<String>> getCategorias() async {
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/categoria'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["categorias"];
      List<String> responseData = [];
      body.forEach((c) =>
          responseData.add(c["nombre"])
      ) ;
      categoria = responseData.last;
      return responseData;
    } else {
      print(response.statusCode);
      categoria = "";
      throw Exception("Unable to retrieve categorias");
    }
  }
  Future<List<String>> getTorneos() async {
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/torneo'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["torneos"];
      List<String> responseData = [];
      body.forEach((t) =>
      {
        if (!responseData.contains(t["nombre"])){
          responseData.add(t["nombre"]),
        }
      }) ;
      torneo = responseData.last;
      return responseData;//.entries.map((data) => data.key).toList();
    } else {
      print(response.statusCode);
      torneo = "";
      throw Exception("Unable to retrieve torneos");
    }
  }


  @override
  void initState() {
    super.initState();
    categorias = getCategorias();
    torneos = getTorneos();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder<List<String>>(
          future: categorias,
          builder: (context, snapshot){
            if (snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }
            if (snapshot.data == null){
              return const CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 0, 5),
              child: SizedBox(
                width: 80,
                child: DropdownButton(
                  //returning a dropdown value for each
                  isExpanded: true,
                  focusColor: const Color(0xFF0A4B8F),
                  value: categoria,
                  items: snapshot.data!.map((c)=> DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (String? value){
                    setState(() {
                      categoria = value!;
                      //executing callback on change
                      change(torneo, categoria, sexo);
                    });
                  },
                ),
              ),
            );
          }
          ),
        FutureBuilder<List<String>>(
            future: torneos,

            builder: (context, snapshot){
              if (snapshot.hasError){
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.data == null){
                return const CircularProgressIndicator();
              }
              return Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: DropdownButton(
                        //returning a dropdown value for each
                        focusColor: const Color(0xFF0A4B8F),
                        isExpanded: true,
                        value: torneo,
                        items: snapshot.data!.map((c)=> DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (String? value){
                          setState(() {
                            torneo = value!;
                            //executing callback on change
                            change(torneo, categoria, sexo);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: DropdownButton(
                      focusColor: const Color(0xFF0A4B8F),
                      value: sexo,
                      items: const [
                        DropdownMenuItem(value: "Masculino",child: Text("Masculino")),
                        DropdownMenuItem(value: "Femenino",child: Text("Femenino")),
                      ],
                      onChanged: (String? value){
                        setState((){
                          sexo = value!;
                          change(torneo, categoria, sexo);
                        });
                      },
                    ),
                  ),
                ],
              );

            }
        ),
      ],
    );
  }
}
