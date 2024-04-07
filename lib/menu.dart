import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:login/pantallas/usuario.dart' as usuario;
import 'package:login/pantallas/agregarcontra.dart' as contras;
import 'package:login/pantallas/perfil.dart' as perfil;
final supabase = Supabase.instance.client;



Future<void> main() async {
  await Supabase.initialize(
    url: 'https://nrkpoxttysbxitcnligl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ya3BveHR0eXNieGl0Y25saWdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE0Njk1MzUsImV4cCI6MjAyNzA0NTUzNX0.UQTzGaDyyCUepnqj2MzxH3XUyTXpsINyuVxDrB_fiYU',
  );

  runApp(MaterialApp(home: Menu(),));
}


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final controlbuscador = TextEditingController();
  List<String> listadeopciones = <String> ['Opcion 1','Opcion 2','Opcion 3'];


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions:  <Widget> [
        IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const usuario.Usuarios()));
        },
        icon: const Icon(Icons.supervised_user_circle_outlined),
        ),
        SizedBox(
          width: 320,
          child:TextField(
          controller: controlbuscador,
          decoration:const InputDecoration (
            labelText: 'Buscar',
            border: OutlineInputBorder()
          )) ,
        ),
        IconButton(onPressed: () {
          DropdownButtonFormField( //Este codigo deberia ser el menu desplegable pero no funca
            items: listadeopciones.map((String e) {
              return DropdownMenuItem<String>(value: e, child: const Text('prueba'),);
            }).toList(),
            onChanged: (e) {
            },
          );
        }, icon: const Icon(Icons.more_horiz))
      ],),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Menu()));
            }, icon: const Icon(Icons.article_sharp)),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const contras.Contras()));
            }, icon: const Icon(Icons.add)),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const perfil.Perfil()));
            }, icon: const Icon(Icons.boy))
          ],
        ),
      ),
    );
  }
}