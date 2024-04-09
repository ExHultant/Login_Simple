import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
      );

  runApp(MaterialApp(home: Registro(),));
}

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final datos = Supabase.instance.client.from('contraseñas').select('''contraseñas,titulos,descripcion,id_usuario''');
  final controlregistrocorreo = TextEditingController();
  final controlregistrocontra = TextEditingController();
  final controlregistrocontrarepetir = TextEditingController();

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de usuario'),),
      body: Center(
        child: FutureBuilder(future: datos, builder: (context, snapshot) {
          if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
         return const CircularProgressIndicator();
        }
        return Column(
          children: [
            const SizedBox(height: 50,),
        SizedBox(
          width: 350,
        child:TextField(
          controller: controlregistrocorreo,
          decoration: const InputDecoration(labelText: 'Ingrese su correo',border: OutlineInputBorder()),
          keyboardType: TextInputType.emailAddress,
        )),
        const SizedBox(height: 30,),
        SizedBox(
          width: 350,
        child: TextField(
          controller: controlregistrocontra,
          decoration: const InputDecoration(labelText: 'Ingrese la contraseña',border: OutlineInputBorder()),
          obscureText: true,
        )),
        const SizedBox(height: 30,),
        SizedBox(
          width: 350,
        child: TextField(
          controller: controlregistrocontrarepetir,
          decoration: const InputDecoration(labelText: 'Repita la contraseña contraseña',border: OutlineInputBorder()),
          obscureText: true,
        )),
        const SizedBox(height: 40,),
        MaterialButton(onPressed: () async {
          //final sesion = 
          //supabase.auth.signUp(password: contracontrol.text,email: emailcontrol.text);
        }, child: const Text('Ingresar'),),
          ],
        );
        }),
      ),
    );
  }
}