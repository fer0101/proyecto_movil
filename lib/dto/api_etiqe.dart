import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

enum EstadoEtiquetas { init, loading, success, failure }

class EtiquetasDTO {
  final List<String> etiquetas;
  final EstadoEtiquetas estado;

  EtiquetasDTO({
    required this.etiquetas,
    required this.estado,
  });

  EtiquetasDTO copyWith({
    List<String>? etiquetas,
    EstadoEtiquetas? estado,
  }) {
    return EtiquetasDTO(
      etiquetas: etiquetas ?? this.etiquetas,
      estado: estado ?? this.estado,
    );
  }
}

class CubitEtiquetas extends Cubit<EtiquetasDTO> {
  CubitEtiquetas()
      : super(EtiquetasDTO(etiquetas: [], estado: EstadoEtiquetas.init));

  void agregarEtiqueta(String etiqueta) {
    final nuevaLista = List<String>.from(state.etiquetas)..add(etiqueta);
    emit(
        state.copyWith(etiquetas: nuevaLista, estado: EstadoEtiquetas.success));
  }

  void editarEtiqueta(int index, String nuevaEtiqueta) {
    final nuevaLista = List<String>.from(state.etiquetas)
      ..[index] = nuevaEtiqueta;
    emit(
        state.copyWith(etiquetas: nuevaLista, estado: EstadoEtiquetas.success));
  }

  void eliminarEtiqueta(int index) {
    final nuevaLista = List<String>.from(state.etiquetas)..removeAt(index);
    emit(
        state.copyWith(etiquetas: nuevaLista, estado: EstadoEtiquetas.success));
  }

  void eliminarTodo() {
    emit(EtiquetasDTO(etiquetas: [], estado: EstadoEtiquetas.success));
  }

  List<String> obtenerLista() {
    return List.from(state.etiquetas);
  }
}
