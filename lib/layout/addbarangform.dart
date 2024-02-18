import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../bloc/addbarang_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class AddBarangForm extends StatefulWidget {
  const AddBarangForm({super.key});

  @override
  State<AddBarangForm> createState() => _AddBarangFormState();
}

class _AddBarangFormState extends State<AddBarangForm> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController merkController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Add Barang')),
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
                decoration: InputDecoration(labelText: 'Stok'),
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
              _pickedImage != null
                  ? Container(
                      height: 300,
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
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
                  if (_pickedImage == null ||
                      namaController.text == "" ||
                      merkController.text == "" ||
                      hargaController.text == "" ||
                      stokController.text == "" ||
                      dateController.text == "") {
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
                    final nama = namaController.text;
                    final merk = merkController.text;
                    final harga = hargaController.text;
                    final stok = stokController.text;
                    final date = dateController.text;
                    final image = _pickedImage;

                    context.read<AddbarangBloc>().add(AddbarangInitial(
                        nama: nama,
                        merk: merk,
                        harga: harga,
                        stok: stok,
                        date: date,
                        image: image!));
                  }
                },
                child: Text('Add Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
