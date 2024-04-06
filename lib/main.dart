import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://xyzcompany.supabase.co',
    anonKey: 'public-anon-key',
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
  Widget build(BuildContext context) {
    return Center(
     child: Column(
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
          await supabase.auth.signUp(password: contracontrol.text,email: emailcontrol.text);
        }, child: const Text('Ingresar'),)
      ],
    ));
  }
}