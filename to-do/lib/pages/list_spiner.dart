// ignore_for_file: camel_case_types, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import '../cubit/CubitEtiquetas.dart';
import '../cubit/cubit_estado_total.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fd.dart';

class listspiner extends StatelessWidget {
  const listspiner({super.key});

  @override
  Widget build(BuildContext context) {
    final controladores = context.watch<ListaSpinerCubit>().state.etiqueta;
    bool allFieldsFilled = true;
    for (var controller in controladores) {
      if (controller.text.isEmpty) {
        allFieldsFilled = false;
        break;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "lista etiquetas",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              "https://img2.wallspic.com/previews/3/9/8/6/6/166893/166893-banner_de_anime-anime-manga-fan_art-kawaii-x750.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...controladores.map((e) => Row(
                        children: [
                          Flexible(
                              child: TextFormField(
                            controller: e,
                          )),
                          IconButton(
                              onPressed: () {
                                final i = controladores.indexOf(e);
                                context.read<ListaSpinerCubit>().eliminar(i);
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ))
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  context.read<ListaSpinerCubit>().agregar();
                },
                child: const Text(
                  "nuevo",
                  style: TextStyle(fontSize: 23, color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  for (var e in controladores) {
                    BlocProvider.of<CubitEtiquetas>(context)
                        .agregarEtiqueta(e.text);
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Formularior()));
                },
                child: const Text(
                  "guardar",
                  style: TextStyle(fontSize: 23, color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "cancelar",
                  style: TextStyle(fontSize: 23, color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
