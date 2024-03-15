import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spiner/cubit/cubitmap.dart';
import 'package:spiner/cubit/logincubit.dart';
import 'package:spiner/pages/fd.dart';
import 'package:spiner/pages/guardarlista.dart';
import 'package:spiner/pages/login_page.dart';
import 'package:spiner/pages/loginmainn.dart';
import 'cubit/CubitEtiquetas.dart';
import 'cubit/cubit_estado_total.dart';
import 'cubit/cubitaladir.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CubitEtiquetas>(create: (_) => CubitEtiquetas()),
      BlocProvider<ListaSpinerCubit>(create: (_) => ListaSpinerCubit()),
      BlocProvider<TareasCubit>(create: (_) => TareasCubit()),
      BlocProvider<logincubit>(create: (_) => logincubit()),
      BlocProvider<MapCubit>(create: (_) => MapCubit()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => logincubit()),
        ],
        child: LoginPagee(),
      ),
    );
  }
}
