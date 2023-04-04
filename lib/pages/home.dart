import 'package:amebal/pages/noticia.dart';
import 'package:amebal/widgets/text_input.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void search(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            TextInput(search),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(width: double.infinity,height: 50, decoration: BoxDecoration(border: Border.all(width: 2)),child: Text("Anuncio")),
            ),
          const Noticia(principal: true, titulo: "Regatas vs Maipu"),
          const Noticia(titulo: "Torneo de infantiles")

        ],
      ),
    );
  }
}
