// ignore_for_file: file_names, must_be_immutable, depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

enum ListaSpinerStatus { init, loading, success, failure }

class ListaSpiner extends Equatable {
  final List<TextEditingController> etiqueta;
  final ListaSpinerStatus status;

  ListaSpiner({required this.etiqueta, required this.status});

  @override
  List<Object?> get props => [etiqueta, status];

  ListaSpiner copyWith({
    List<TextEditingController>? etiqueta,
    ListaSpinerStatus? status,
  }) {
    return ListaSpiner(
      etiqueta: etiqueta ?? this.etiqueta,
      status: status ?? this.status,
    );
  }
}

class ListaSpinerCubit extends Cubit<ListaSpiner> {
  ListaSpinerCubit()
      : super(ListaSpiner(etiqueta: const [], status: ListaSpinerStatus.init));

  Future<void> agregar() async {
    final NuevaEtiqueta = TextEditingController();
    final nuevasEtiquetas = List<TextEditingController>.from(state.etiqueta)
      ..add(NuevaEtiqueta);
    final nuevaLista = state.copyWith(
        etiqueta: nuevasEtiquetas, status: ListaSpinerStatus.success);
    emit(nuevaLista);
  }

  Future<void> editar(int index, TextEditingController nuevaEtiqueta) async {
    final nuevasEtiquetas = List<TextEditingController>.from(state.etiqueta)
      ..[index] = nuevaEtiqueta;
    final nuevaLista = state.copyWith(
        etiqueta: nuevasEtiquetas, status: ListaSpinerStatus.success);
    emit(nuevaLista);
  }

  Future<void> eliminar(int index) async {
    final nuevasEtiquetas = List<TextEditingController>.from(state.etiqueta)
      ..removeAt(index);
    final nuevaLista = state.copyWith(
        etiqueta: nuevasEtiquetas, status: ListaSpinerStatus.success);
    emit(nuevaLista);
  }

  Future<void> eliminarTodo() async {
    final nuevaLista =
        state.copyWith(etiqueta: [], status: ListaSpinerStatus.success);
    emit(nuevaLista);
  }

  List<TextEditingController> obtenerTodo() {
    return List<TextEditingController>.from(state.etiqueta);
  }
}
