
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginCubit():super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPassword = false;
  void changePasswordVisibility()
  {
    showPassword = !showPassword;
    emit(LoginChangePassState());
  }
  void onLoginPressed()
  {
    emit(LoginLoadingState());
    if(!formKey.currentState!.validate())
    {
      emit(LoginSuccessState());
    }
    else
    {
      emit(LoginErrorState("Complete Data"));
    }
  }
}