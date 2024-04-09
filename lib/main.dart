import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:login/menu.dart' as menu;
import 'package:login/registro.dart' as registro;
final supabase = Supabase.instance.client;


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Login'),),
        body: const Login()
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailcontrol = TextEditingController();
  final contracontrol = TextEditingController();
  
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
    return Center(
     child:
      Column(
      children: [
        const SizedBox(height: 50,),
        SizedBox(
          width: 350,
        child:TextField(
          controller: emailcontrol,
          decoration: const InputDecoration(labelText: 'Correo',border: OutlineInputBorder()),
          keyboardType: TextInputType.emailAddress,
        )),
        const SizedBox(height: 30,),
        SizedBox(
          width: 350,
        child: TextField(
          controller: contracontrol,
          decoration: const InputDecoration(labelText: 'Contraseña',border: OutlineInputBorder()),
          obscureText: true,
        )),
        const SizedBox(height: 40,),
        MaterialButton(onPressed: () async {
          //final sesion =
          //supabase.auth.signUp(password: contracontrol.text,email: emailcontrol.text);
          //final AuthResponse res = 
          /*await supabase.auth.signUp(
          email: emailcontrol.text,
          password: contracontrol.text);*/
          Navigator.push(context, MaterialPageRoute(builder: (context) => const menu.Menu()));
        }, child: const Text('Ingresar'),),
        const SizedBox(height: 20,),
        MaterialButton(onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const registro.Registro()));
        }, child: const Text('Registrarte'),),
      ],
    ));
  }
}