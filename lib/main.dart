import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'features/test_firebase.dart';
import 'features/test_map.dart';
import 'features/test_nav_bar.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await TranslationHelper.setLanguage();
  print('\x1B[31mThis is red text\x1B[0m');
  print('\x1B[32mThis is green text\x1B[0m');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print("firebase user name ${user.displayName}");
      print("firebase user email ${user.email}");
      print("firebase user emailVerified ${user.emailVerified}");
      print("firebase user phoneNumber ${user.phoneNumber}");
      print("firebase user photoURL ${user.photoURL}");
      print('User is signed in!');
    }
  });
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
        home: TestFirebaseView(),
        // home: TestNavBar(),
        // home: SplashView(),
      ),
    );
  }
}
