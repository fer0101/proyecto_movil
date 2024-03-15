import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spiner/pages/guardarlista.dart';
import 'package:spiner/pages/list_spiner.dart';

import '../cubit/CubitEtiquetas.dart';
import '../cubit/cubitmap.dart';
import '../models/mo.dart';

// ignore: camel_case_types
class name extends StatelessWidget {
  String titulotarea;
  name({super.key, required this.titulotarea});

  @override
  Widget build(BuildContext context) {
    String? etique;
    //final valid = GlobalKey<FormState>();
    final text1 = TextEditingController();
    final text2 = TextEditingController();
    final nomeblock =
        BlocProvider.of<TareasCubit>(context).state.tareas[titulotarea];

    return Scaffold(
      appBar: AppBar(
        title: const Text("nuevo formulario"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(titulotarea),
              Text(nomeblock.fecha),
              Text(nomeblock.nuevatarea),

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
                  print(value2);
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
                    items: BlocProvider.of<CubitEtiquetas>(context)
                        .obtenerLista()
                        .map((valorlist) => DropdownMenuItem(
                              value: valorlist,
                              child: Text(valorlist),
                            ))
                        .toList(),
                    onChanged: (value3) {
                      etique = value3 as String;
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
                    BlocProvider.of<TareasCubit>(context)
                        .eliminarTarea(titulotarea);
                    BlocProvider.of<TareasCubit>(context).agregarTarea(
                        text1.text,
                        mod(
                            fecha: text2.text,
                            nuevatarea: etique.toString(),
                            confi: 'pendiente'));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const guardarlista()));
                  },
                  child: const Text("modificar")),

              TextButton(
                  onPressed: () {
                    BlocProvider.of<TareasCubit>(context)
                        .eliminarTarea(titulotarea);
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const guardarlista()));
                  },
                  child: const Text("eliminar")),
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
