import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TareasStatus { init, loading, success, failure }

class TareasCubit extends Cubit<TareasState> {
  TareasCubit() : super(TareasState());

  void agregarTarea(String titulo, dynamic descripcion) async {
    emit(state.copyWith(status: TareasStatus.loading));
    try {
      final Map<String, dynamic> newtarea = Map.from(state.tareas)
        ..[titulo] = descripcion;
      emit(state.copyWith(tareas: newtarea, status: TareasStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TareasStatus.failure));
    }
  }

  void editarTarea(String titulo, dynamic nuevaDescripcion) async {
    emit(state.copyWith(status: TareasStatus.loading));
    try {
      final Map<String, dynamic> editt = Map.from(state.tareas)..remove(titulo);
      emit(TareasState(tareas: editt, status: TareasStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TareasStatus.failure));
    }
  }

  void eliminarTarea(String titulo) async {
    emit(state.copyWith(status: TareasStatus.loading));
    try {
      final Map<String, dynamic> eliminartarea2 = Map.from(state.tareas)
        ..remove(titulo);
      emit(
          state.copyWith(tareas: eliminartarea2, status: TareasStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TareasStatus.failure));
    }
  }
}

class TareasState extends Equatable {
  final Map<String, dynamic> tareas;
  final TareasStatus status;

  TareasState({Map<String, dynamic>? tareas, TareasStatus? status})
      : tareas = tareas ?? {},
        status = status ?? TareasStatus.init;

  @override
  List<Object?> get props => [tareas, status];

  TareasState copyWith({Map<String, dynamic>? tareas, TareasStatus? status}) {
    return TareasState(
      tareas: tareas ?? this.tareas,
      status: status ?? this.status,
    );
  }
}
