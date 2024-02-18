import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:thiftstore2/repository/barang_repository.dart';

part 'managebarang_event.dart';
part 'managebarang_state.dart';

class ManagebarangBloc extends Bloc<ManagebarangEvent, ManagebarangState> {
  BarangRepository barangRepository;

  ManagebarangBloc({required this.barangRepository})
      : super(LoadingBarangState()) {
    on<LoadListBarangEvent>(_listbarang);
  }

  _listbarang(LoadListBarangEvent event, Emitter emit) async {
    String key = event.keyword;

    emit(LoadingBarangState());
    List res = await barangRepository.getBarangList(key);
    // log(res.toString());
    emit(ListBarangState(barang: res, searchText: key));
  }
}
