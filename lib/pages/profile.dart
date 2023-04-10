import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  void search(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(radius: 50,),
          Text("Nombre Apellido"),
          Text("HABILITADO"),
          SizedBox(height: 40,),
          Text("Club Mendoza de Regatas"),
          Text("Juvenil")
        ],
      ),
    );
  }
}
