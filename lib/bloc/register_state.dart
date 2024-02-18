part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {}

final class RegisterInitialState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final String message;

  RegisterSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
