import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:spiner/service/login_service.dart';

import 'loginstatus.dart';

class logincubit extends Cubit<LoginState> {
  logincubit() : super(const LoginState());
  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await LoginService.login(email, password);
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception
    //catch (e)
    {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
