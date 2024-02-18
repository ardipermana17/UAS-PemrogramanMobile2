part of 'addbarang_bloc.dart';

@immutable
sealed class AddbarangState extends Equatable {}

final class AddbarangInitialState extends AddbarangState {
  @override
  List<Object> get props => [];
}

class AddBarangLoadingState extends AddbarangState {
  @override
  List<Object> get props => [];
}

class AddBarangSuccessState extends AddbarangState {
  final String message;

  AddBarangSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddBarangErrorState extends AddbarangState {
  final String error;

  AddBarangErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
