import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:thiftstore2/repository/barang_repository.dart';

part 'editbarang_event.dart';
part 'editbarang_state.dart';

class EditbarangBloc extends Bloc<EditbarangEvent, EditbarangState> {
  final BarangRepository barangRepository;

  EditbarangBloc({required this.barangRepository})
      : super(EditbarangInitial()) {
    on<SetInit>(_setInit);
    on<ClickEdit>(_editbarang);
  }

  _setInit(SetInit event, Emitter emit) async {
    // emit(LoadingEdit());
    emit(EditbarangInitial());
  }

  _editbarang(ClickEdit event, Emitter emit) async {
    try {
      // state 1
      emit(LoadingEdit());

      final result = await barangRepository.editBarang(
        id: event.id,
        nama: event.nama,
        merk: event.merk,
        harga: event.harga,
        stok: event.stok,
        date: event.date,
        image: event.image,
      );

      // state 2 if success
      if (result == true) {
        emit(SuccessEdit(message: "Barang ${event.nama} berhasil diubah"));
      } else {
        emit(ErrorEdit(error: 'Error: Gagal Merubah Barang'));
      }
    } catch (error) {
      //state 3 if error
      emit(ErrorEdit(error: 'Error: $error'));
    }
  }
}
