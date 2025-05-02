import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nti_r2/core/cache/cache_data.dart';
import 'package:nti_r2/core/cache/cache_helper.dart';
import 'package:nti_r2/core/translation/translation_helper.dart';
import 'package:nti_r2/core/utils/app_colors.dart';

import 'core/utils/app_text_styles.dart';
import 'features/auth/views/splash_view.dart';
import 'features/home/cubit/user_cubit/user_cubit.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await TranslationHelper.setLanguage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> UserCubit(),
      child: GetMaterialApp(
        locale: Locale(CacheData.lang!),
        translations: TranslationHelper(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: AppTextStyles.fontFamily,
          scaffoldBackgroundColor: AppColors.scaffoldBackground
        ),
        home: SplashView(),
      ),
    );
  }
}
