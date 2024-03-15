import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

enum EstadoEtiquetas { init, loading, success, failure }

class CubitEtiquetas extends Cubit<EstadoCubitEtiquetas> {
  CubitEtiquetas()
      : super(const EstadoCubitEtiquetas([], EstadoEtiquetas.init));

  void agregarEtiqueta(String etiqueta) {
    final nuevaLista = List<String>.from(state.etiquetas)..add(etiqueta);
    emit(EstadoCubitEtiquetas(nuevaLista, EstadoEtiquetas.success));
  }

  void editarEtiqueta(int index, String nuevaEtiqueta) {
    final nuevaLista = List<String>.from(state.etiquetas)
      ..[index] = nuevaEtiqueta;
    emit(EstadoCubitEtiquetas(nuevaLista, EstadoEtiquetas.success));
  }

  void eliminarEtiqueta(int index) {
    final nuevaLista = List<String>.from(state.etiquetas)..removeAt(index);
    emit(EstadoCubitEtiquetas(nuevaLista, EstadoEtiquetas.success));
  }

  void eliminarTodo() {
    emit(const EstadoCubitEtiquetas([], EstadoEtiquetas.success));
  }

  List<String> obtenerLista() {
    return List.from(state.etiquetas);
  }
}

class EstadoCubitEtiquetas extends Equatable {
  final List<String> etiquetas;
  final EstadoEtiquetas estado;

  const EstadoCubitEtiquetas(this.etiquetas,
      [this.estado = EstadoEtiquetas.init]);

  @override
  List<Object> get props => [etiquetas, estado];
}
