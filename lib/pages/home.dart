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
  List<Map<String, dynamic>> news = [];
  void getNews() async {
    try {
      var response = await http.get(
          Uri.parse('http://10.0.2.2:8000/articulo'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body)["articulos"];

        List<Map<String, dynamic>> responseData = body.map(
                (data) => {"id": data["id"], "title": data["titulo"].toString()}
        ).toList();
        first = responseData[0];
        responseData.removeAt(0);
        news = responseData;
      }else {
        print(response.statusCode);
        throw "Unable to retrieve news";
      }
    }
    catch (e){
      print(e);
    }
  }

  void search(){
    setState(() {
        getNews();
    });
  }
  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    getNews();
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextInput(search),
          Expanded(
            child: ListView(
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(width: double.infinity,height: 50, decoration: BoxDecoration(border: Border.all(width: 2)),child: Text("Anuncio")),
              ),
              ArticleWidget(main: true, id: first["id"], title: first["title"],),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: news.map((n)=>ArticleWidget(id: n["id"], title: n["title"])).toList(),
              ),
              OutlinedButton(onPressed: search, child: Text("news")),
            ]),
          )


        ],
      ),
    );
  }
}
