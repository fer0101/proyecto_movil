import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spiner/pages/guardarlista.dart';

import '../cubit/CubitEtiquetas.dart';
import '../cubit/cubitmap.dart';
import '../models/mo.dart';
import 'list_spiner.dart';

class Formularior extends StatefulWidget {
  const Formularior({super.key});

  @override
  State<Formularior> createState() => _FormulariorState();
}

class _FormulariorState extends State<Formularior> {
  String? etique;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CubitEtiquetas>(context).obtenerLista();
  }

  List<DropdownMenuItem<String>> etiquetas2() {
    final listaDeCadenasDeTexto =
        BlocProvider.of<CubitEtiquetas>(context).obtenerLista();
    return listaDeCadenasDeTexto
        .map((cadenaDeTexto) => DropdownMenuItem<String>(
              value: cadenaDeTexto,
              child: Text(cadenaDeTexto),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final valid = GlobalKey<FormState>();
    final text1 = TextEditingController();
    final text2 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("nuevo formulario"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                "descripcion",
                textAlign: TextAlign.right,
              ),
              TextFormField(
                validator: (value1) {
                  if (value1!.isEmpty) {
                    return "campos basios";
                  }
                  return null;
                },
                controller: text1,
                decoration: const InputDecoration(
                  label: Text("excriba el titulo de la tarea"),
                  border: OutlineInputBorder(),
                  prefix: Icon(Icons.add),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "fecha",
                textAlign: TextAlign.right,
              ),
              TextFormField(
                validator: (value2) {
                  if (value2!.isEmpty) {
                    return "fecha basia";
                  }
                  const patron = r'^\d{2}\/\d{2}\/\d{4}$';
                  final regExp = RegExp(patron);
                  if (!regExp.hasMatch(value2)) {
                    return 'La fecha debe tener el formato dd/MM/YYYY';
                  }
                  return null;
                },
                controller: text2,
                decoration: const InputDecoration(
                  label: Text("excriba el titulo de la tarea"),
                  border: OutlineInputBorder(),
                  prefix: Icon(Icons.date_range_sharp),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "etiqueta",
                textAlign: TextAlign.right,
              ),
              Row(
                children: <Widget>[
                  DropdownButton(
                    value: etique,
                    items: etiquetas2(),
                    onChanged: (value3) {
                      setState(() {
                        etique = value3 as String;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const listspiner()));
                      },
                      icon: const Icon(
                        Icons.adb,
                      )),
                ],
              ),
              //buton2
              TextButton(
                  onPressed: () {
                    BlocProvider.of<TareasCubit>(context).agregarTarea(
                        text1.text,
                        mod(
                            fecha: text2.text,
                            nuevatarea: etique.toString(),
                            confi: 'pendiente'));
                    // Navigator.pop(context);
                    print(BlocProvider.of<TareasCubit>(context)
                        .state
                        .tareas
                        .toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => guardarlista()));
                  },
                  child: const Text("guardar")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancelar")),
            ],
          ),
        ),
      ),
    );
  }
}
