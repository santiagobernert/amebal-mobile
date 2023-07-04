import 'package:amebal/pages/login.dart';
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
  late int username;
  late String password;
  late Future<User> user;
  late Future<Player> player;

  Future<User> getUser() async {
      var response = await http.post(
          Uri.parse('http://10.0.2.2:8000/login'),
          body: json.encode({"dni": username, "contraseña": password}));
      if (response.statusCode == 200) {
        dynamic user = jsonDecode(response.body)["usuario"];
        return User.fromJson(user);
      }
      else {
        print(response.statusCode);
        throw Exception("Unable to retrieve user");
      }
  }

  Future<Player> getPlayer(id) async {
      var getplayer = await http.get(
        Uri.parse('http://10.0.2.2:8000/jugador?id=$id',)
      );
      if (getplayer.statusCode == 200){
      dynamic playerJson = jsonDecode(getplayer.body)["jugador"];
      return Player.fromJson(playerJson);
    }else {
      print(getplayer.statusCode);
      throw Exception("Unable to retrieve player");
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    // if username and password are valid, set state
      setState(() {
        username = usernameController.text as int;
        password = passwordController.text;
      });
    usernameController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
    user = getUser();
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: user,
        builder: (context, user) {
        if (user.hasError){
          return Login(login);
        }
        if (user.data == null){
          return const CircularProgressIndicator();
        }
      return FutureBuilder<Player>(
        future: getPlayer(user.data!.id),
        builder: (context, player) {
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
                        Container(width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(border: Border.all(width: 2)),
                            child: const Text("Anuncio")),
                        const CircleAvatar(radius: 50,),
                        const SizedBox(height: 10,),
                        Text("${user.data!.nombre} ${user.data!.apellido}"),
                        Text(player.data!.estado.toUpperCase()),
                        const SizedBox(height: 40,),
                        Text(player.data!.club),
                        Text(player.data!.categoria),
                        Text(player.data!.carnet),
                        Container(width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(border: Border.all(width: 2)),
                            child: const Text("Anuncio")),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2)),
                              child: const Text("Anuncio")),
                          const Text("Datos del usuario", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserData(Icons.assignment_ind_rounded, "DNI ",
                                    "${user.data!.dni}"),
                                UserData(
                                    Icons.email_rounded, "Email ", user.data!.email),
                                Row(
                                    children: [
                                      Flexible(
                                        child: Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          spacing: 10,
                                          runSpacing: 10,
                                          direction: Axis.horizontal,
                                          children: player.data!
                                              .getPlayerData()
                                              .entries
                                              .map((data) =>
                                              UserData(icons[data.key] ?? Icons.add,
                                                  data.key, data.value.toString()))
                                              .toList()
                                          ,
                                        ),
                                      )
                                    ]
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.directions_car, size: 350),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.file_copy_rounded),
                          const Text("Ficha Médica"),
                          IconButton(onPressed: (){},
                            icon: const Icon(Icons.download),
                            style: ButtonStyle(),)
                        ],)
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      );
    });
  }
}
