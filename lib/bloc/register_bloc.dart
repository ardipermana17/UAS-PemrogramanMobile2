import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:thiftstore2/repository/login_repository.dart';
import 'dart:io';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LoginRepository registerRepository;

  RegisterBloc({required this.registerRepository})
      : super(RegisterInitialState()) {
    on<RegisterInitial>(_addregister);
  }

  _addregister(RegisterInitial event, Emitter emit) async {
    try {
      // state 1
      emit(RegisterLoadingState());

      // state 2
      final result = await registerRepository.addRegister(
        username: event.username,
        password: event.password,
        name: event.name,
      );

      // state 3 if success
      emit(RegisterSuccessState(message: result));

      await Future.delayed(Duration(seconds: 3));

      emit(RegisterInitialState());
    } catch (error) {
      //state 3 if error
      emit(RegisterErrorState(error: 'Error: $error'));
    }
  }
}
