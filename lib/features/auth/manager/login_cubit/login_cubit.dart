
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_r2/features/auth/data/repo/auth_repo.dart';
import 'package:nti_r2/features/home/data/models/user_model.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginCubit():super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();

  bool showPassword = false;
  void changePasswordVisibility()
  {
    showPassword = !showPassword;
    emit(LoginChangePassState());
  }
  void onLoginPressed() async
  {
    if(!formKey.currentState!.validate()) return;
    emit(LoginLoadingState());
    var result = await authRepo.login(username: emailController.text, password: passwordController.text);
    result.fold((error)
      {
        emit(LoginErrorState(error));
      }, (userModel)
      {
        emit(LoginSuccessState(userModel));
      }
    );
  }
}