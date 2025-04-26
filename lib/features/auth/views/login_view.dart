import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_r2/features/auth/manager/login_cubit/login_state.dart';

import '../manager/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loign'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: Builder(
          builder: (context2) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<LoginCubit, LoginState>(
                builder: (context, state)
                {
                  print("re build");
                  return Form(
                    key: LoginCubit.get(context2).formKey,
                    child: Column(
                      children:
                      [
                        TextFormField(
                          controller: LoginCubit.get(context2).emailController,
                          validator: (String? value)
                          {
                            if(value!.isEmpty || !value.contains('@'))
                            {
                              return 'Enter valid email';
                            }
                            return null;
                          },

                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: LoginCubit.get(context2).passwordController,
                          validator: (String? value)
                          {
                            if(value!.isEmpty || value.length<6)
                            {
                              return 'Enter valid password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40,),
                        ElevatedButton(onPressed:LoginCubit.get(context2).onLoginPressed, child: Text('Login')),
                        SizedBox(height: 20,),
                      if(state is LoginErrorState)
                        Text(state.error),
                      ],
                    ),
                  );
                },
                listener: (context, state)
                {
                  if(state is LoginSuccessState)
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                        content: Text('Success')
                    ));
                  }
                },
              ),
            );
          }
        ),
      ),
    );
  }
}
