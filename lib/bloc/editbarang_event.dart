part of 'editbarang_bloc.dart';

@immutable
sealed class EditbarangEvent extends Equatable {}

final class SetInit extends EditbarangEvent {
  @override
  List<Object?> get props => [];
}

final class ClickEdit extends EditbarangEvent {
  final String id;
  final String nama;
  final String merk;
  final String harga;
  final String stok;
  final String date;
  final File? image;

  ClickEdit({
    required this.id,
    required this.nama,
    required this.merk,
    required this.harga,
    required this.stok,
    required this.date,
    this.image,
  });

  @override
  List<Object?> get props => [nama, merk, harga, stok, date, image];
}
