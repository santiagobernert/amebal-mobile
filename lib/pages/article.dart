import 'package:amebal/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:amebal/themes/light.dart';
import 'package:amebal/themes/dark.dart';

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
      tags: json['tags'].split('-'),
      image: json['portada'],
      body: json['cuerpo'],
      date: json['fecha'],
    );
  }
}



class ArticlePage extends StatefulWidget {
  Article article;
  ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ThemeMode currentTheme = ThemeMode.system;
  void toggleTheme(){
    setState(() {
      currentTheme = currentTheme == ThemeMode.dark? ThemeMode.light : ThemeMode.dark;
    });
  }
  void back(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: light,
      darkTheme: dark,
      themeMode: currentTheme,
      home: Scaffold(
        appBar: CustomAppBar(toggle: toggleTheme, currentTheme: currentTheme),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(
                onPressed: back,
              ),
              const SizedBox(height: 10,),
              Text(widget.article.title, textAlign: TextAlign.left, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: widget.article.tags.map((t) => Container(
                  margin: const EdgeInsets.fromLTRB(0,0,5,0),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.zero),
                  child: MaterialButton(
                    onPressed: ()=>{},
                    color: Colors.blue.shade900,
                    splashColor: Colors.blue,
                    elevation: 0,
                    minWidth: 10,
                    height: 20,
                    child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 10),)),
                ),
              ).toList(),),
              const SizedBox(height: 10,),
              const Icon(Icons.landscape, size: 200,),
              Text(widget.article.date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, fontStyle: FontStyle.italic),),
              const SizedBox(height: 10,),
              Text(widget.article.body)
            ],
          ),
        ),
      ),
    );
  }
}
