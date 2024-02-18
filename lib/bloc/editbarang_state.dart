part of 'editbarang_bloc.dart';

@immutable
sealed class EditbarangState extends Equatable {}

final class EditbarangInitial extends EditbarangState {
  @override
  List<Object?> get props => [];
}

final class LoadingEdit extends EditbarangState {
  @override
  List<Object?> get props => [];
}

final class SuccessEdit extends EditbarangState {
  final String message;

  SuccessEdit({required this.message});
  @override
  List<Object?> get props => [message];
}

final class ErrorEdit extends EditbarangState {
  final String error;

  ErrorEdit({required this.error});
  List<Object?> get props => [error];
}
