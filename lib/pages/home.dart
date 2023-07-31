import 'dart:convert';

import 'package:amebal/widgets/article_widget.dart';
import 'package:amebal/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map first = {};
  late Future<List<Map<String, dynamic>>> news;
  Future<List<Map<String, dynamic>>> getNews() async {
      var response = await http.get(
          Uri.parse('http://10.0.2.2:8000/articulo'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body)["articulos"];

        List<Map<String, dynamic>> responseData = body.map(
                (data) => {"id": data["id"], "title": data["titulo"].toString()}
        ).toList();
        first = responseData[0];
        responseData.removeAt(0);
        return responseData;
      }else {
        print(response.statusCode);
        throw "Unable to retrieve news";
      }
  }

  @override
  void initState() {
    super.initState();
    news = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getNews(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Padding(
            padding: EdgeInsets.all(200.0),
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextInput((){}),
              Container(width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: const Text("Anuncio")),
              Expanded(
                child: ListView(
                  children: [
                  ArticleWidget(main: true, id: first["id"], title: first["title"],),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: snapshot.data!.map((n)=>ArticleWidget(id: n["id"], title: n["title"])).toList(),
                  ),

                ]),
              ),
              Container(width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: const Text("Anuncio")),

            ],
          ),
        );
      }
    );
  }
}
