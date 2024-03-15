import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState(map: {}));

  void addItem(String key, dynamic value) {
    final newMap = Map<String, dynamic>.from(state.map);
    newMap[key] = value;
    emit(state.copyWith(map: newMap));
  }

  void removeItem(String key) {
    final newMap = Map<String, dynamic>.from(state.map);
    newMap.remove(key);
    emit(state.copyWith(map: newMap));
  }

  void clearItems() {
    emit(state.copyWith(map: {}));
  }
}

class MapState extends Equatable {
  final Map<String, dynamic> map;

  const MapState({required this.map});

  MapState copyWith({Map<String, dynamic>? map}) {
    return MapState(map: map ?? this.map);
  }

  @override
  List<Object?> get props => [map];
}
