import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Layout/Layout.dart';
import 'package:social_app/modules/Login/cubit/cubit.dart';
import 'package:social_app/modules/Login/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../Register/RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();

    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Center(
                child: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: FormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black', fontSize: 40),
                            ),
                            Text(
                              "ta dadaaaaaaaaaaaaa",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black',
                                  fontSize: 20,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 30),
                            defaultTextFormField(
                                controller: EmailController,
                                type: TextInputType.emailAddress,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your E-mail.";
                                  }
                                },
                                label: "Email",
                                prefix: Icons.email),
                            SizedBox(height: 10),
                            defaultTextFormField(
                                controller: PasswordController,
                                type: TextInputType.visiblePassword,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your password.";
                                  }
                                },
                                onSubmit: () {
                                  // if (FormKey.currentState!.validate()) {
                                  //   SocialLoginCubit.get(context).UserLogin(
                                  //       email: EmailController.text,
                                  //       password: PasswordController.text);
                                  // }
                                },
                                label: "Password",
                                prefix: Icons.lock_outline,
                                suffix: SocialLoginCubit.get(context).suffix,
                                isPassword:
                                    SocialLoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  SocialLoginCubit.get(context).changeSuffix();
                                }),
                            SizedBox(height: 20),
                            ConditionalBuilder(
                                condition: state is! SocialloginLoadingState,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (FormKey.currentState!.validate()) {
                                        SocialLoginCubit.get(context).UserLogin(
                                            email: EmailController.text,
                                            password: PasswordController.text);
                                      }
                                    },
                                    text: "Login"),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    )),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don/'t have an account?"),
                                TextButton(
                                    onPressed: () {
                                     navigateTo(context, RegisterScreen());
                                    },
                                    child: Text("Register now!"))
                              ],
                            ),
                          ],
                        ),
                      ))),
            )));
      }, listener: (context, state) {
        if (state is SocialLoginSuccessState)
         {
          CacheHelper.SaveData(key: 'uID', value: state.uId).then((value) {navigateAndFinish(context, Layout());});

          } else {
            // showToast(
            //     text: state.loginmodel.message.toString(), state: ToastState.ERROR);
            //     CacheHelper.SaveData(
            //       key: 'token',
            //        value: state.loginmodel.data!.token).then((value) 
            //        {
            //         token=state.loginmodel.data!.token!;
            //         navigateAndFinish(context, HomeScreen());}); 
          }
        
      }),
    );
    throw UnimplementedError();
  }

}