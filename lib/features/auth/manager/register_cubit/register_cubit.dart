
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Register_state.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool showConfirmPassword = false;
  void changePasswordVisibility()
  {
    showPassword = !showPassword;
    emit(RegisterChangePassState());
  }
  void changeConfirmPasswordVisibility()
  {
    showConfirmPassword = !showConfirmPassword;
    emit(RegisterChangePassState());
  }
  void onRegisterPressed()
  {
    emit(RegisterLoadingState());
    if(formKey.currentState!.validate())
    {
      emit(RegisterSuccessState());
    }
    else
    {
      emit(RegisterErrorState('Complete the data'));
    }

  }
}