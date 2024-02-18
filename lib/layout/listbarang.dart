import 'package:thiftstore2/layout/detailbarang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/managebarang_bloc.dart';

class ListBarang extends StatelessWidget {
  final List barang;
  String searchText; // Assuming your barang data is a list of maps

  ListBarang({super.key, required this.barang, this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    TextEditingController _search = TextEditingController(text: searchText);
    return Scaffold(
      // appBar: AppBar(title: Text("List Barang")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          TextField(
            controller: _search,
            decoration: InputDecoration(labelText: 'Cari Barang'),
          ),
          ElevatedButton(
            onPressed: () {
              final search = _search.text;

              // Dispatch login event to Bloc
              context
                  .read<ManagebarangBloc>()
                  .add(LoadListBarangEvent(keyword: search));
            },
            child: Text('Cari'),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: barang.length,
              itemBuilder: (context, index) {
                final Map barangItem = barang[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      barangItem['img'], // Replace with
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                    title: Text(barangItem['nama_barang']),
                    subtitle: Text(barangItem['date']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBarang(
                                  barangId: barangItem['id_barang'],
                                )),
                      ).then((value) {
                        // log("ret $value");
                        // if (value == 'reload') {
                        final search = _search.text;

                        // Dispatch login event to Bloc
                        context
                            .read<ManagebarangBloc>()
                            .add(LoadListBarangEvent(keyword: search));
                        // }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
