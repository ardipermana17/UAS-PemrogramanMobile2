import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/addbarang_bloc.dart';
import 'addbarangform.dart';

class BarangForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddbarangBloc, AddbarangState>(
      builder: (context, state) {
        if (state is AddbarangInitialState) {
          return AddBarangForm();
        } else if (state is AddBarangLoadingState) {
          return CircularProgressIndicator();
        } else if (state is AddBarangSuccessState) {
          return Text(state.message);
        } else if (state is AddBarangErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return Container();
        }
        // return AddBarangForm();
      },
    );
  }
}
