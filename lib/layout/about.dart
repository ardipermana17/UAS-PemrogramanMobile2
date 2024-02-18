import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            "Thrift Store",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 2,
              fontStyle: FontStyle.italic,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Text(
              ' Aplikasi Thrift Store adalah toko online yang menjual barang-barang bekas seperti pakaian, tas hingga sepatu. Aplikasi Toko ini datang menjadi solusi kepada pengguna ketika tidak memiliki modal yang banyak dan tetap tampil berkelas.'),
          Text(
              'Fitur yang ada pada aplikasi ini, yaitu fitur login, fitur register, fitur tambah, edit, dan hapus barang , fitur list barang, detail barang dan tentang aplikasi Thrift Store.'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          "@Copyright by Azhar Kurniawan_22552012036 dan Ardi Permana_18111406",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            height: 2,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
