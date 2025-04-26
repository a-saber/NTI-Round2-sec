
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginCubit():super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  String? error;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void onLoginPressed()
  {
    error = null;
    if(!formKey.currentState!.validate())
    {
      error = 'Complete the form and fix errors';
    }
    if(error == null)
    {
      emit(LoginSuccessState());
    }
    else
    {
      emit(LoginErrorState(error!));
    }
  }
}