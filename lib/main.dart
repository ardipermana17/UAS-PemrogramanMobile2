import 'package:thiftstore2/bloc/addbarang_bloc.dart';
import 'package:thiftstore2/bloc/detail_bloc.dart';
import 'package:thiftstore2/bloc/editbarang_bloc.dart';
import 'package:thiftstore2/bloc/managebarang_bloc.dart';
import 'package:thiftstore2/bloc/register_bloc.dart';
import 'package:thiftstore2/repository/barang_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thiftstore2/repository/login_repository.dart';
import 'package:thiftstore2/bloc/login_bloc.dart';
import 'package:thiftstore2/layout/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => LoginRepository(),
          ),
          RepositoryProvider(
            create: (context) => BarangRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LoginBloc(loginRepository: context.read<LoginRepository>())
                    ..add(const InitLogin()),
            ),
            BlocProvider(
                create: (context) => AddbarangBloc(
                    barangRepository: context.read<BarangRepository>())),
            BlocProvider(
                create: (context) => ManagebarangBloc(
                    barangRepository: context.read<BarangRepository>())),
            BlocProvider(
                create: (context) => DetailBloc(
                    barangRepository: context.read<BarangRepository>())),
            BlocProvider(
                create: (context) => EditbarangBloc(
                    barangRepository: context.read<BarangRepository>())),
            BlocProvider(
                create: (context) => RegisterBloc(
                    registerRepository: context.read<LoginRepository>()))
          ],
          child: MaterialApp(
            title: "Home",
            home: HomePage(),
          ),
        ));
  }
}
