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
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
  );

  runApp(const MaterialApp(
    home: Menu(),
  ));
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final controlbuscador = TextEditingController();
  List<String> listadeopciones = <String>['Opcion 1', 'Opcion 2', 'Opcion 3'];
  Future<List<Map<String, dynamic>>> datos =
      supabase.from('contraseñas').select('''contras,titulos,descripcion''');

  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    controlbuscador.addListener(() {
      filterData();
    });
  }

  @override
  void dispose() {
    controlbuscador.dispose();
    super.dispose();
  }

  void filterData() {
    Future.delayed(Duration.zero, () async {
      String searchText = controlbuscador.text;
      final data = await datos;
      if (searchText.isEmpty) {
        setState(() {
          filteredData = data;
        });
      } else {
        setState(() {
          filteredData = data
              .where((element) =>
                  element['titulos'].toLowerCase().contains(searchText.toLowerCase()))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.05; // 5% of screen width

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const usuario.Usuarios()));
                  },
                  icon: const Icon(Icons.supervised_user_circle_outlined, color: Colors.white),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                      controller: controlbuscador,
                      decoration: const InputDecoration(
                          labelText: 'Buscar Contraseña', border: OutlineInputBorder())),
                ),
                IconButton(
                    onPressed: () {
                      DropdownButtonFormField(
                        //Este codigo deberia ser el menu desplegable pero no funca
                        items: listadeopciones.map((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: const Text('prueba'),
                          );
                        }).toList(),
                        onChanged: (e) {},
                      );
                    },
                    icon: const Icon(Icons.more_horiz, color: Colors.white))
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: datos,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    debugPrint('Cambios recibidos por stream ${snapshot.data}');
                    final data = filteredData;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Text('Titulos: ${data[index]['titulos']}'),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const modificar
                                                        .Modificar()));
                                      },
                                      icon: const Icon(Icons.mode, color: Colors.white))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      'Descripcion: ${data[index]['descripcion']}')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Contraseña: ${data[index]['contras']}'),
                                ],
                              )
                            ],
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Menu()));
                },
                icon: const Icon(Icons.article_sharp)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const contras.Contras()));
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const perfil.Perfil()));
                },
                icon: const Icon(Icons.boy))
          ],
        ),
      ),
    );
  }
}
