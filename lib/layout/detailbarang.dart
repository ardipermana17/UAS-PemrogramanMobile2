import 'package:thiftstore2/bloc/detail_bloc.dart';
import 'package:thiftstore2/layout/detailload.dart';
import 'package:thiftstore2/layout/error_message.dart';
import 'package:thiftstore2/layout/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBarang extends StatefulWidget {
  final int barangId;
  const DetailBarang({super.key, required this.barangId});

  @override
  State<DetailBarang> createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context
          .read<DetailBloc>()
          .add(LoadBarangEvent(barangId: widget.barangId.toString()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailInitial) {
          return LoadingIndicator();
        } else if (state is LoadFailed) {
          return ErrorMessage(message: state.msg);
        } else if (state is BarangDeleted) {
          return Scaffold(
            appBar: (AppBar(
              title: const Text("Hapus Sukses"),
            )),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Center(
                      child: Text("Barang '${state.nama}' berhasil dihapus")),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop('reload');
                      },
                      child: const Text('Kembali Ke List Barang'),
                    ),
                  ),
                ],
              )),
            ),
          );
        } else if (state is DetailLoaded) {
          return DetailViewLoad(
              id: state.barang['id_barang'].toString(),
              nama: state.barang['nama_barang'].toString(),
              url: state.barang['img'],
              merk: state.barang['merk'].toString(),
              harga: state.barang['harga'].toString(),
              stok: state.barang['stok'].toString(),
              date: state.barang['date'].toString());
        } else {
          return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("UnKnown Error"))));
        }
      },
    );
  }
}
