part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {}

final class RegisterInitial extends RegisterEvent {
  final String username;
  final String password;
  final String name;

  RegisterInitial({
    required this.username,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [username, password, name];
}
