
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_r2/features/home/data/models/user_model.dart';

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
    if(formKey.currentState!.validate())
    {
      UserModel userModel = UserModel(userName: emailController.text,);
      emit(LoginSuccessState(userModel));
    }
    else
    {
      emit(LoginErrorState("Complete Data"));
    }
  }
}