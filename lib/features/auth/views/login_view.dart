import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nti_r2/core/helper/my_navigator.dart';
import 'package:nti_r2/core/helper/my_validator.dart';
import 'package:nti_r2/core/translation/translation_helper.dart';
import 'package:nti_r2/core/translation/translation_keys.dart';
import 'package:nti_r2/core/utils/app_assets.dart';
import 'package:nti_r2/core/widgets/custom_filled_btn.dart';
import 'package:nti_r2/core/widgets/custom_form_field.dart';
import 'package:nti_r2/features/auth/manager/login_cubit/login_state.dart';
import 'package:nti_r2/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:nti_r2/features/home/cubit/user_cubit/user_cubit.dart';
import 'package:nti_r2/features/home/views/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> LoginCubit(),
      child: Scaffold(
        body: Column(
          children:
          [
            // flag
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                AppAssets.flag,
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.36,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 23,),

            // form
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state)
              {
                if(state is LoginErrorState)
                {
                  Get.showSnackbar(GetSnackBar(message: state.error,));

                }
                else if(state is LoginSuccessState)
                {
                  UserCubit.get(context).getUserData(user: state.userModel);
                  MyNavigator.goTo(screen: ()=> HomeView(), isReplace: true);
                }
              },
              builder: (context, state)
              {
                return Form(
                  key: LoginCubit.get(context).formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children:
                      [
                        CustomFormField(
                          validator: EmailValidator(),
                          controller: LoginCubit.get(context).emailController,
                        ),
                        SizedBox(height: 20,),
                        CustomFormField(
                          obscureText:LoginCubit.get(context).showPassword,
                          validator: PasswordValidator(),
                          controller: LoginCubit.get(context).passwordController,
                          suffixIcon: IconButton(onPressed: LoginCubit.get(context).changePasswordVisibility,
                              icon: Icon(Icons.lock)),
                        ),
                        SizedBox(height: 20,),


                        CustomFilledBtn(onPressed: LoginCubit.get(context).onLoginPressed,
                            text: TranslationKeys.login.tr
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: CustomFilledBtn(onPressed: ()
                              {
                                TranslationHelper.changeLanguage(true);
                              },
                                  text: "ar"
                              ),
                            ),
                            Expanded(
                              child: CustomFilledBtn(onPressed: ()
                              {
                                TranslationHelper.changeLanguage(false);
                              },
                                  text: "en"
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
