import 'package:nti_r2/features/home/data/models/user_model.dart';

abstract class LoginState {}
class LoginInitState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState
{
  UserModel userModel;
  LoginSuccessState(this.userModel);
}
class LoginErrorState extends LoginState
{
  final String error;
  LoginErrorState(this.error);
}
class LoginChangePassState extends LoginState{}