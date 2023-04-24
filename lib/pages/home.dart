import 'dart:convert';

import 'package:amebal/widgets/noticia.dart';
import 'package:amebal/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<String>> getNews() async {
    print('get news');
    var response = await http.get(Uri.parse('http://127.0.0.1:8000/club'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<String> news = body.map(
              (dynamic n) => n.nombre.toString()
      ).toList();
      print(news);
      return news;
    }else {
      throw "Unable to retrieve news";
    }
  }

  void search(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
            TextInput(search),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(width: double.infinity,height: 50, decoration: BoxDecoration(border: Border.all(width: 2)),child: Text("Anuncio")),
            ),
          const Noticia(principal: true, titulo: "Regatas vs Maipu"),
          const Noticia(titulo: "Torneo de infantiles"),
          const Noticia(titulo: "Torneo de infantiles"),
          OutlinedButton(onPressed: getNews, child: Text("news"))

        ],
      ),
    );
  }
}
