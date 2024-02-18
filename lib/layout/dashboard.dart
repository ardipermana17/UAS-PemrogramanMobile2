import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thiftstore2/layout/addbarang.dart';
// import 'package:thiftstore2/layout/managebarang.dart';
import 'package:thiftstore2/layout/tabbar.dart';
import '../bloc/login_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  final String sessionToken;

  WelcomeScreen({required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome!'),
            Text('Session Token: $sessionToken'),
            ElevatedButton(
              onPressed: () {
                // Dispatch logout event to Bloc
                context.read<LoginBloc>().add(const ProsesLogout());
              },
              child: Text('Logout'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigasi ke halaman Add News
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => BarangForm()),
            //     );
            //   },
            //   child: Text('Tambah Barang'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigasi ke halaman Manage News
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ManageBarang()),
            //     );
            //   },
            //   child: Text('Kelola Barang'),
            // ),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Tabbar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabBarExample()),
                );
              },
              child: Text('Kelola Barang'),
            ),
          ],
        ),
      ),
    );
  }
}
