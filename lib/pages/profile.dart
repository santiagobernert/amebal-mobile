import 'package:amebal/widgets/UserData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User{
  int id;
  String nombre;
  String apellido;
  int dni;
  String email;
  String contrasena;
  int rol;
  User(this.id, this.nombre, this.apellido, this.dni, this.email, this.contrasena, this.rol);

  factory User.fromJson(Map<String, dynamic> json){
    return User(
    json["id"],
    json["nombre"],
    json["apellido"],
    json["dni"],
    json["email"],
    json["contraseña"],
    json["rol"],
    );}
  }

class Player {
  int id;
  String nombre;
  String apellido;
  int dni;
  String nacimiento;
  String sexo;
  String estado;
  String categoria;
  String club;
  int peso;
  int estatura;
  String mano;
  String posicion;
  String sanguineo;
  String telefono;
  String provincia;
  String departamento;
  String localidad;
  String domicilio;
  String obrasocial;
  String carnet;

  Player(
      this.id, this.nombre, this.apellido, this.dni, this.nacimiento, this.sexo, this.estado, this.categoria, this.club,
      this.peso, this.estatura, this.mano, this.posicion, this.sanguineo, this.telefono, this.provincia, this.departamento,
      this.localidad, this.domicilio, this.obrasocial, this.carnet);

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
      json["id"],
      json["nombre"],
      json["apellido"],
      json["dni"],
      json["nacimiento"],
      json["sexo"],
      json["estado"],
      json["categoria"] ?? "",
      json["club"],
      json["peso"],
      json["estatura"],
      json["mano"],
      json["posicion"],
      json["sanguineo"],
      json["telefono"],
      json["provincia"],
      json["departamento"],
      json["localidad"],
      json["domicilio"],
      json["obrasocial"],
      json["carnet"],
    );
  }

  Map<String, dynamic> getPlayerData() => {
    "nombre": nombre,
    "apellido": apellido,
    "dni": dni,
    "nacimiento": nacimiento,
    "sexo": sexo,
    "estado": estado,
    "categoria": categoria,
    "club": club,
    "peso (kg)": peso,
    "estatura (cm)": estatura,
    "mano": mano,
    "posicion": posicion,
    "sanguineo": sanguineo,
    "telefono": telefono,
    "provincia": provincia,
    "departamento": departamento,
    "localidad": localidad,
    "domicilio": domicilio,
    "obrasocial": obrasocial,
  };

}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User user;
  late Player player;
  void getProfile() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/login'), body: jsonEncode({'dni': 44556778, 'contraseña': 'sf778'}), headers: headers);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["usuario"];
      user = User.fromJson(body);
      var getplayer = await http.get(
        Uri.parse('http://10.0.2.2:8000/jugador?id=${user.id}',)
      );
      dynamic playerJson = jsonDecode(getplayer.body)["jugador"];
      player = Player.fromJson(playerJson);
    }else {
      print(response.statusCode);
      throw Exception("Unable to retrieve user");
    }
  }

  Map<String, IconData> icons = {
    "nacimiento": Icons.calendar_month_rounded,
    "sexo": Icons.person,
    "mano": Icons.back_hand,
    "telefono": Icons.phone,
    "domicilio": Icons.house_rounded,
  };

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void search(){
    setState(() {
      getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    getProfile();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.lightBlueAccent,
            tabs: [
              Tab(text: "Perfil",),
              Tab(text: "Datos",),
              Tab(text: "Carnet",),
              Tab(text: "Archivos",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50,),
                  SizedBox(height: 10,),
                  Text("${user.nombre} ${user.apellido}"),
                  Text(player.estado.toUpperCase()),
                  SizedBox(height: 40,),
                  Text(player.club),
                  Text(player.categoria),
                  Text(player.carnet),
                  OutlinedButton(onPressed: search, child: Text('get')),
                ],
              ),
            ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Datos del usuario"),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      UserData(Icons.assignment_ind_rounded, "DNI ", "${user.dni}"),
                      UserData(Icons.email_rounded, "Email ", "${user.email}"),
                      Row(
                          children: [
                            Flexible(
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                direction: Axis.horizontal,
                                children: player.getPlayerData().entries.map((data) =>
                                    UserData(icons[data.key]??Icons.add, data.key, data.value.toString())).toList()
                              ,
                          ),
                            )]
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
            Icon(Icons.directions_car, size: 350),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.file_copy_rounded),
                  Text("Ficha Médica"),
                  IconButton(onPressed: getProfile, icon: Icon(Icons.download), style: ButtonStyle(),)
                ],)
              ],
            ),
          ],
        ),
      ),
    );

  }
}
