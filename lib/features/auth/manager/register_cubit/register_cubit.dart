
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nti_r2/features/auth/data/repo/auth_repo.dart';

import 'Register_state.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  AuthRepo authRepo = AuthRepo();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  XFile? image;
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
  void onRegisterPressed()async
  {
    if(formKey.currentState!.validate())
    {
      emit(RegisterLoadingState());
      var result = await authRepo.register(
        username: emailController.text,
        password: passwordController.text,
        image: image
      );
      result.fold(
        (String error) // left
        {
          emit(RegisterErrorState(error));
        },
        (r) // right
        {
          emit(RegisterSuccessState());
        });
    }

  }
}