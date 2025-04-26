import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loign'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: LoginCubit.get(context).formKey,
                child: Column(
                  children:
                  [
                    TextFormField(
                      controller: LoginCubit.get(context).emailController,
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
                      controller: LoginCubit.get(context).passwordController,
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
                    ElevatedButton(onPressed:LoginCubit.get(context).onLoginPressed, child: Text('Login')),
                    SizedBox(height: 20,),
                    Text(LoginCubit.get(context).error??'')
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
