import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../bloc/editbarang_bloc.dart';

class EditForm extends StatefulWidget {
  final String id, nama, url, merk, harga, stok, date;
  const EditForm(
      {required this.id,
      required this.nama,
      this.url = "",
      required this.merk,
      required this.harga,
      required this.stok,
      required this.date});
  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController merkController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? _pickedImage;
  @override
  void initState() {
    super.initState();
    namaController.text = widget.nama;
    merkController.text = widget.merk;
    hargaController.text = widget.harga;
    stokController.text = widget.stok;
    dateController.text = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Barang')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Barang'),
              ),
              TextField(
                controller: merkController,
                decoration: InputDecoration(labelText: 'Merk'),
              ),
              TextField(
                controller: hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
              TextField(
                controller: stokController,
                decoration: InputDecoration(labelText: 'stok'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime(2000), //DateTime.now() - not to allow to
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateController.text =
                          formattedDate; // set output date to TextField
                    });
                  }
                },
              ),
              _pickedImage == null
                  ? Image.network(
                      widget.url, // Replace with the actual image URL
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              _pickedImage != null
                  ? SizedBox(
                      width: double.infinity,
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.contain,
                      ))
                  : SizedBox.shrink(),
              ElevatedButton(
                onPressed: () async {
                  // Fungsi pemilihan file dari perangkat lokal dan file
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg'],
                  );

                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _pickedImage = File(result.files.single.path!);
                    });
                  }
                },
                child: Text('Pick Image (.jpg)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if ((_pickedImage == null && widget.url == "") ||
                      namaController.text == "" ||
                      merkController.text == "" ||
                      hargaController.text == "" ||
                      stokController.text == "" ||
                      dateController.text == "") {
                    log("Masuk Kondisi If Edit Klik Tombol");
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('No Image'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Silahkan Lengkapi Data'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  } else {
                    log("Masuk Kondisi Else Edit Klik Tombol");
                    final id = widget.id;
                    final nama = namaController.text;
                    final merk = merkController.text;
                    final harga = hargaController.text;
                    final stok = stokController.text;
                    final date = dateController.text;
                    final image = _pickedImage;

                    context.read<EditbarangBloc>().add(ClickEdit(
                          id: id,
                          nama: nama,
                          merk: merk,
                          harga: harga,
                          stok: stok,
                          date: date,
                          image: image,
                        ));
                  }
                },
                child: Text('Edit Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
