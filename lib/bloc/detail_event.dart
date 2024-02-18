part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent extends Equatable {}

class LoadBarangEvent extends DetailEvent {
  final String barangId;

  LoadBarangEvent({required this.barangId});

  @override
  List<Object?> get props => [barangId];
}

final class DeleteBarang extends DetailEvent {
  final String id;
  final String nama;

  DeleteBarang({required this.id, required this.nama});
  @override
  List<Object?> get props => [id, nama];
}
