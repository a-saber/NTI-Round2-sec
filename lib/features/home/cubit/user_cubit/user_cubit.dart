import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_r2/features/home/cubit/user_cubit/user_state.dart';
import 'package:nti_r2/features/home/data/models/user_model.dart';
import 'package:nti_r2/features/home/data/repo/home_repo.dart';

class UserCubit extends Cubit<UserState>
{
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  HomeRepo repo = HomeRepo();
  void getUserData({required UserModel user})
  {
    emit(UserGetSuccess(userModel: user));
  }
  Future<bool> getUserDataFromAPI()async
  {
    var response =await repo.getUserData();

    return response.fold((error)
    {
      emit(UserGetError(error: error));
      return false;
    }, (userModel)
    {
      emit(UserGetSuccess(userModel: userModel));
      return true;
    });
  }

}