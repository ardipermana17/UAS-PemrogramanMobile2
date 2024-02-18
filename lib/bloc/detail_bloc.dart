import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:thiftstore2/repository/barang_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  BarangRepository barangRepository;

  DetailBloc({required this.barangRepository}) : super(DetailInitial()) {
    on<LoadBarangEvent>(_loadBarang);
    on<DeleteBarang>(_deletebarang);
  }

  _loadBarang(LoadBarangEvent event, Emitter emit) async {
    String barangId = event.barangId;

    emit(DetailInitial());

    Map res = await barangRepository.selectBarang(barangId);

    log("RESLOAD $res");

    if (res['status'] == true) {
      emit(DetailLoaded(barang: res));
    } else {
      emit(LoadFailed(msg: res['msg']));
    }
  }

  _deletebarang(DeleteBarang event, Emitter emit) async {
    String key = event.id;
    String nama = event.nama;
    emit(DetailInitial());
    bool res = await barangRepository.deleteBarang(key);
    log("OOO $res");
    if (res == true) {
      emit(BarangDeleted(nama: nama));
    } else {
      Map res = await barangRepository.selectBarang(key);

      log("RESLOAD $res");

      if (res['status'] == true) {
        emit(DetailLoaded(barang: res));
      } else {
        emit(LoadFailed(msg: res['msg']));
      }
    }
  }
}
