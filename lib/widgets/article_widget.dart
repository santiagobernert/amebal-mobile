import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amebal/pages/article.dart';



class ArticleWidget extends StatefulWidget {
  final int id;
  final bool main;
  final String title;
  const ArticleWidget({Key? key, required this.id, this.main=false, required this.title}) : super(key: key);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  void click() async {
    var getArticle = await http.get(
        Uri.parse('http://10.0.2.2:8000/articulo?id=${widget.id}',)
    );
    print(getArticle.body);
    dynamic articleJson = jsonDecode(getArticle.body)["articulo"];
    print(articleJson);
    Article article = Article.fromJson(articleJson);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticlePage(article: article)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        width: widget.main? double.infinity : MediaQuery.of(context).size.width * 0.42,
        color: Colors.amberAccent,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        height: widget.main? 170 : 120,
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomLeft,
        child: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
    );
  }
}
