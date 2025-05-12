import 'package:nti_r2/features/home/data/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}
class UserGetError extends UserState {
  String error;
  UserGetError({required this.error});
}
class UserGetSuccess extends UserState
{
  UserModel userModel;
  UserGetSuccess({required this.userModel});
}