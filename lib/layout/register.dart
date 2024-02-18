import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';
import 'registerform.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is RegisterInitialState) {
          return RegisterForm();
        } else if (state is RegisterLoadingState) {
          return CircularProgressIndicator();
        } else if (state is RegisterSuccessState) {
          return Text(state.message);
        } else if (state is RegisterErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return Container();
        }
        // return RegisterForm();
      },
    );
  }
}
