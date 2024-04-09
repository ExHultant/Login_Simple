import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:login/pantallas/agregarcontra.dart' as contras;
import 'package:login/menu.dart' as menu;
final supabase = Supabase.instance.client;

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
      );

  runApp(MaterialApp(home: Perfil(),));
}

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text('Perfil'),
      automaticallyImplyLeading: false,),
            bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const menu.Menu()));
            }, icon: const Icon(Icons.article_sharp)),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const contras.Contras()));
            }, icon: const Icon(Icons.add)),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Perfil()));
            }, icon: const Icon(Icons.boy))
          ],
        ),
      ),
      
    );
  }
}