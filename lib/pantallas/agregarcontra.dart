import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';
final supabase = Supabase.instance.client;


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://nrkpoxttysbxitcnligl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ya3BveHR0eXNieGl0Y25saWdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE0Njk1MzUsImV4cCI6MjAyNzA0NTUzNX0.UQTzGaDyyCUepnqj2MzxH3XUyTXpsINyuVxDrB_fiYU',
  );

  runApp(MaterialApp(home: Contras(),));
}

String contragenerador({
  bool connumeros = false,
  bool conespecial = false,
}){

  String contra= "";
    const mayus = "ABCDEFGHIJKLMNOPQRSTWYXZ";
    const minus = "abcdefghijklmnopqrstwyxz";
    const numeros = "1234567890";
    const especial = "!#&/()=?¡";
   const tamano = 10;
contra += mayus + minus;
contra+= numeros;
contra+= especial;

  return List.generate(tamano, (index) {
    final listarandome = Random.secure().nextInt(contra.length);
    return contra[listarandome];
  }).join("");
}


class Contras extends StatefulWidget {
  const Contras({super.key});

  @override
  State<Contras> createState() => _ContrasState();
}

class _ContrasState extends State<Contras> {

  final datos = Supabase.instance.client.from('contraseñas').stream(primaryKey: ['id']);
  final controldetitulo = TextEditingController();
  final controldecontra = TextEditingController();
  final controldedescripcion = TextEditingController();

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
      appBar: AppBar(title: const Text('Agregar contraseña'),),
      body: Center(
        child:Column(
          children: [
            const SizedBox(height: 50,),
        SizedBox(
          width: 350,
        child:TextField(
          controller: controldetitulo,
          decoration: const InputDecoration(labelText: 'Ingrese el titulo deseado',border: OutlineInputBorder()),
          keyboardType: TextInputType.emailAddress,
        )),
        const SizedBox(height: 30,),
        SizedBox(
          width: 350,
        child: TextField(
          controller: controldecontra,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        )),
        const SizedBox(height: 30,),
        SizedBox(
          width: 350,
        child: TextField(
          controller: controldedescripcion,
          decoration: const InputDecoration(labelText: 'Ingrese la descripcion',border: OutlineInputBorder()),
        )),
        const SizedBox(height: 40,),
        StreamBuilder(stream: datos, builder: (context, snapshot){
          return
          Column(children: [
          const Text(''),
          ElevatedButton(
          onPressed:() async {
          await supabase.from('contraseñas').upsert([{'Contraseñas':controldecontra.text, 'titulos':controldetitulo.text, 'descripcion':controldedescripcion.text,'id_usuario':'21541'}]).select('Contraseñas,titulos,descripcion,id_usuario');
          controldecontra.clear();
          controldetitulo.clear();
          controldedescripcion.clear();
          }, 
          child: const Text("Agregar contraseña", style: TextStyle(color: Color.fromARGB(255, 0, 173, 204)),)),
          ElevatedButton(onPressed: () {
            controldecontra.text = contragenerador();
          }, child: const Text('Generar contraseña'))
          ],);
        }
      )],
        ) ,
      )
       
        )
    ;
  }
}