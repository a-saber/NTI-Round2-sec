import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nti_r2/core/widgets/image_manager/cubit/image_manager_state.dart';

class ImageManagerCubit extends Cubit<ImageManagerState>
{
  ImageManagerCubit() : super(ImageManagerInitialState());
  static ImageManagerCubit get(context) => BlocProvider.of(context);

  void pickImage({ImageSource source = ImageSource.gallery}) async
  {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);
    if(image != null)
    {
      emit(ImageManagerPickedState(image: image));
    }
  }
}