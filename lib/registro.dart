import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qndkjfhorupharaphaoa.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuZGtqZmhvcnVwaGFyYXBoYW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MDQwMjEsImV4cCI6MjAyODA4MDAyMX0.Fok8bU8EcKUZig0MJZjxQZxOf6ZWnWvjwbzwmRvBU-E',
  );

  runApp(const MaterialApp(
    home: Registro(),
  ));
}

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final datos = Supabase.instance.client
      .from('contraseñas')
      .select('''contras,titulos,descripcion,id''');
  final controlregistrocorreo = TextEditingController();
  final controlregistrocontra = TextEditingController();
  final controlregistrocontrarepetir = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de usuario'),
      ),
      body: Center(
        child: FutureBuilder(
            future: datos,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: controlregistrocorreo,
                        decoration: const InputDecoration(
                          hintText: 'Ingrese su correo',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 71, 47, 78)),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: controlregistrocontra,
                        decoration: const InputDecoration(
                          hintText: 'Ingrese la contraseña',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 71, 47, 78)),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: controlregistrocontrarepetir,
                        decoration: const InputDecoration(
                          hintText: 'Repita la contraseña',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 71, 47, 78)),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: MaterialButton(
                      onPressed: () async {
                        final email = controlregistrocorreo.text;
                        final password = controlregistrocontra.text;
                        final passwordRepeat =
                            controlregistrocontrarepetir.text;

                        if (password != passwordRepeat) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Las contraseñas no coinciden'),
                            ),
                          );
                          return;
                        }

                        try {
                          // Primero, registra al usuario
                          await supabase.auth
                              .signUp(email: email, password: password);

                          // Luego, inicia sesión con las mismas credenciales
                          await supabase.auth.signInWithPassword(
                              email: email, password: password);

                          // Aquí puedes navegar a la página principal de tu aplicación
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al registrar: $error'),
                            ),
                          );
                        }
                      },
                      color: const Color.fromARGB(255, 71, 47, 78),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minWidth: double.infinity,
                      height: 50,
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
