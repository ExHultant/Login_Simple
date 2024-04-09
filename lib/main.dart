import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:login/menu.dart' as menu;
import 'package:login/registro.dart' as registro;

final supabase = Supabase.instance.client;

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        scaffoldBackgroundColor: Colors.deepPurple,
      ),
      home: const Login(),
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.white,
              ),
              const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Ingresa tus datos para continuar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: emailcontrol,
                  decoration: const InputDecoration(
                    hintText: 'Correo electrónico',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 24, 17, 56)),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: contracontrol,
                  decoration: const InputDecoration(
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 71, 47, 78)),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (emailcontrol.text.isEmpty || contracontrol.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Por favor, rellene todos los campos')),
                    );
                    return;
                  }

                  try {
                    final response = await supabase.auth.signInWithPassword(
                      email: emailcontrol.text,
                      password: contracontrol.text,
                    );

                    if (response.user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al iniciar sesión'),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const menu.Menu()),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al iniciar sesión: $e'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 71, 47, 78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const registro.Registro()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 71, 47, 78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Registrarte',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
