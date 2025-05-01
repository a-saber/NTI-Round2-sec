import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_r2/core/helper/my_navigator.dart';
import 'package:nti_r2/core/helper/my_validator.dart';
import 'package:nti_r2/core/translation/translation_keys.dart';
import 'package:nti_r2/core/utils/app_assets.dart';
import 'package:nti_r2/core/widgets/custom_filled_btn.dart';
import 'package:nti_r2/core/widgets/custom_form_field.dart';
import 'package:nti_r2/features/auth/manager/register_cubit/Register_state.dart';
import 'package:nti_r2/features/auth/manager/register_cubit/register_cubit.dart';

import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> RegisterCubit(),
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
            BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state)
              {
                if(state is RegisterErrorState)
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));

                }
                else if(state is RegisterSuccessState)
                {
                  MyNavigator.goTo(screen: ()=> LoginView(), isReplace: true);
                }
              },
              builder: (context, state)
              {
                return Form(
                  key: RegisterCubit.get(context).formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children:
                      [
                        CustomFormField(
                          validator: EmailValidator(),
                          controller: RegisterCubit.get(context).emailController,
                        ),
                        SizedBox(height: 20,),
                        CustomFormField(
                        obscureText:RegisterCubit.get(context).showPassword,
                          validator: PasswordValidator(),
                          controller: RegisterCubit.get(context).passwordController,
                        suffixIcon: IconButton(onPressed: RegisterCubit.get(context).changePasswordVisibility,
                            icon: Icon(Icons.lock)),
                        ),
                        SizedBox(height: 20,),
                        CustomFormField(
                          obscureText:RegisterCubit.get(context).showConfirmPassword,
                          validator: PasswordValidator(confirm: RegisterCubit.get(context).passwordController.text),
                        suffixIcon: IconButton(onPressed: RegisterCubit.get(context).changeConfirmPasswordVisibility,
                            icon: Icon(Icons.lock)),
                          controller: RegisterCubit.get(context).passwordConfirmController,
                        ),
                        SizedBox(height: 20,),

                        CustomFilledBtn(onPressed: RegisterCubit.get(context).onRegisterPressed,
                            text: TranslationKeys.register
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
