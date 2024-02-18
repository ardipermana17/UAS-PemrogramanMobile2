import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/managebarang_bloc.dart';
import 'loading.dart';
import 'listbarang.dart';

class ManageBarang extends StatefulWidget {
  @override
  State<ManageBarang> createState() => _ManageBarangState();
}

class _ManageBarangState extends State<ManageBarang> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log("INIT STATE");
      context.read<ManagebarangBloc>().add(LoadListBarangEvent(keyword: ""));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagebarangBloc, ManagebarangState>(
        builder: (context, state) {
      if (state is LoadingBarangState) {
        return LoadingIndicator();
      } else if (state is ListBarangState) {
        log("state ${state.searchText}");
        return ListBarang(
          barang: state.barang,
          searchText: state.searchText,
        );
      } else {
        return Container();
      }
    });
  }
}
