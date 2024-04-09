import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
      );

  runApp(MaterialApp(home: Modificar(),));
}




class Modificar extends StatefulWidget {
  const Modificar({super.key});

  @override
  State<Modificar> createState() => _ModificarState();
}

class _ModificarState extends State<Modificar> {
  final controltitulo = TextEditingController();
  final controldescripcion = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    Supabase.instance.client
        .channel('contraseñas')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'contraseñas',
            callback: (payload) {
              debugPrint('');
             
            })
        .subscribe();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modificar'),),
      body: Center(
        child: Column(
          children: [
            TextField(
                    controller: controltitulo,
                    decoration:const InputDecoration(
                    labelText: 'ingrese denuevo el titulo',
                    border: OutlineInputBorder()
                  )),
            TextField(
                    controller: controldescripcion,
                    decoration:const InputDecoration(
                    labelText: 'ingrese denuevo la descripcion',
                    border: OutlineInputBorder()
                  )),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () async {
              await Supabase.instance.client.from('contraseñas').update({'titulos':controltitulo.text,'descripcion':controldescripcion}).match({'contras':controldescripcion});
            }, child: const Text('Modificar'))
          ],
        ),
      ),
    );
  }
}