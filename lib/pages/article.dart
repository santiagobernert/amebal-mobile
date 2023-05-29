import 'package:flutter/material.dart';

class Article{
  final int id;
  final String title;
  final List<String> tags;
  final String date;
  final String body;
  final String image;
  Article({required this.id, required this.title, required this.tags, required this.date, required this.body, required this.image});

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      id: json["id"],
      title: json["titulo"],
      tags: json['tags'],
      image: json['portada'],
      body: json['cuerpo'],
      date: json['fecha'],
    );
  }
}



class ArticlePage extends StatelessWidget {
  Article article;
  ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(article.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Row(children: article.tags.map((t) => OutlinedButton(onPressed: ()=>{}, child: Text(t, style: TextStyle(backgroundColor: Colors.blue.shade900,),))).toList(),),
          SizedBox(height: 10,),
          Icon(Icons.landscape, size: 40,),
          SizedBox(height: 10,),
          Text(article.body)
        ],
      ),
    );
  }
}
