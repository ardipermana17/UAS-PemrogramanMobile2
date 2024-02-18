part of 'detail_bloc.dart';

@immutable
sealed class DetailState extends Equatable {}

final class DetailInitial extends DetailState {
  @override
  List<Object?> get props => [];
}

final class DetailLoaded extends DetailState {
  final Map barang;

  DetailLoaded({required this.barang});

  @override
  List<Object?> get props => [barang];
}

final class LoadFailed extends DetailState {
  final String msg;

  LoadFailed({this.msg = "Failed to Load Barang"});
  @override
  List<Object?> get props => [msg];
}

final class BarangDeleted extends DetailState {
  final String nama;

  BarangDeleted({required this.nama});
  @override
  List<Object?> get props => [nama];
}
