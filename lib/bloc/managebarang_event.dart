part of 'managebarang_bloc.dart';

@immutable
sealed class ManagebarangEvent extends Equatable {}

final class LoadListBarangEvent extends ManagebarangEvent {
  final String keyword;

  LoadListBarangEvent({this.keyword = ""});

  @override
  List<Object?> get props => [];
}
