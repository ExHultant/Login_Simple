import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:login/pantallas/usuario.dart' as usuario;
import 'package:login/pantallas/agregarcontra.dart' as contras;
import 'package:login/pantallas/perfil.dart' as perfil;
import 'package:login/pantallas/modificar.dart' as modificar;
final supabase = Supabase.instance.client;



Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
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
  final datos = supabase.from('contraseñas').select('''contras,titulos,descripcion''');


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
      body: Center(
        child:
         FutureBuilder(future: datos, builder: (context,snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
         return const CircularProgressIndicator();
        }
        debugPrint('Cambios recibidos por stream ${snapshot.data}');
        final data = snapshot.data as List;
        return ListView.builder(itemCount :data.length, itemBuilder:(context, index) {
          return Column(
            children: [
              const SizedBox(height: 50,),
              Row(children: [
              Text('Titulos: ' + data[index]['titulos'].toString()),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const modificar.Modificar()));
              }, icon: Icon(Icons.mode))
              
            ],
            ), Row(
              children: [
                Text('Descripcion: ' + data[index]['descripcion'].toString())
              ],
            ),
            Row(
              children: [
                Text('Contraseña: ' + data[index]['contras'].toString()),
              ],
            )
            ],
          );
        });
        }),
      ),
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