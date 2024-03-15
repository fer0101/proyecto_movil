import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spiner/models/mo.dart';
import '../cubit/cubitmap.dart';
import 'fd.dart';
import 'fd3.dart';

class guardarlista extends StatelessWidget {
  const guardarlista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("todo app"),
      ),
      body: (BlocProvider.of<TareasCubit>(context).state.tareas.isNotEmpty)
          ? ListView.builder(
              itemCount:
                  BlocProvider.of<TareasCubit>(context).state.tareas.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final calbin = BlocProvider.of<TareasCubit>(context)
                    .state
                    .tareas
                    .keys
                    .toList()[index]; //
                final valor = BlocProvider.of<TareasCubit>(context)
                    .state
                    .tareas[calbin]; //
                if (valor is mod) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => name(
                                    titulotarea: calbin,
                                  )));
                    },
                    //
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //
                                      Text("tarea: $calbin"),
                                      Text("Fecha de la tarea: ${valor.fecha}"),
                                      Text("Etiqueta: ${valor.nuevatarea}"),
                                      //
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text("Estado: ${valor.confi}"),
                                  TextButton(
                                      onPressed: () {
                                        BlocProvider.of<TareasCubit>(context)
                                            .eliminarTarea(valor.nuevatarea);
                                        BlocProvider.of<TareasCubit>(context)
                                            .agregarTarea(
                                                calbin,
                                                mod(
                                                    fecha: valor.fecha,
                                                    nuevatarea: valor.nuevatarea
                                                        .toString(),
                                                    confi: 'completado'));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const guardarlista()));
                                      },
                                      child: const Text("completar")),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: ListTile(
                          title: Text("La tarea '$calbin' no es válido."),
                        ),
                      ),
                    ),
                  );
                }
              })
          : const Center(
              child: Text("no hay tareas"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Formularior()));
        },
        child: const Icon(Icons.add_alarm_outlined),
      ),
    );
  }
}
