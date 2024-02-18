part of 'managebarang_bloc.dart';

@immutable
sealed class ManagebarangState extends Equatable {}

class LoadingBarangState extends ManagebarangState {
  @override
  List<Object?> get props => [];
}

class ListBarangState extends ManagebarangState {
  final List barang;
  final String searchText;
  ListBarangState({required this.barang, this.searchText = ""});

  @override
  List<Object?> get props => [barang, searchText];
}
