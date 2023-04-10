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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(radius: 20,),
        Text("Nombre Apellido"),
        Text("HABILITADO"),
        SizedBox(height: 40,),
        Text("Club Mendoza de Regatas"),
        Text("Juvenil")
      ],
    );
  }
}
