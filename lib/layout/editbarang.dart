import 'package:thiftstore2/layout/editform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/editbarang_bloc.dart';
import 'loading.dart';
import 'error_message.dart';

class EditBarang extends StatefulWidget {
  final String id, nama, url, merk, harga, stok, date;
  const EditBarang(
      {required this.id,
      required this.nama,
      required this.url,
      required this.merk,
      required this.harga,
      required this.stok,
      required this.date});

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<EditbarangBloc>().add(SetInit());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditbarangBloc, EditbarangState>(
      builder: (context, state) {
        if (state is EditbarangInitial) {
          return EditForm(
              id: widget.id,
              nama: widget.nama,
              url: widget.url,
              merk: widget.merk,
              harga: widget.harga,
              stok: widget.stok,
              date: widget.date);
        } else if (state is LoadingEdit) {
          return LoadingIndicator();
        } else if (state is SuccessEdit) {
          return Scaffold(
            appBar: AppBar(title: const Text("Edit Barang")),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop('reload');
                        },
                        child: const Text("Lihat Barang"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is ErrorEdit) {
          return ErrorMessage(message: "Gagal Edit");
        } else {
          return Container();
        }
      },
    );
  }
}
