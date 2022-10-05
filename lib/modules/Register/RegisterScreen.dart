import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Layout/Layout.dart';
import 'package:social_app/modules/Login/LoginScreen.dart';
import 'package:social_app/modules/Login/cubit/cubit.dart';
import 'package:social_app/modules/Login/cubit/states.dart';
import 'package:social_app/modules/Register/cubit/cubit.dart';
import 'package:social_app/modules/Register/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();
    var NameController=TextEditingController();
    var PhoneController=TextEditingController();

    return BlocProvider(create: (context) =>SocialRegisterCubit(),
    child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
      builder: (context,state){
        var cubit=SocialRegisterCubit.get(context);
        return Scaffold(
      appBar: AppBar(),
      body:Center(
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
                              "REGISTER",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black', fontSize: 40),
                            ),
                            Text(
                              "Register now to browse our hot offers",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black',
                                  fontSize: 20,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 30),
                            defaultTextFormField(
                                controller: NameController,
                                type: TextInputType.name,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your name.";
                                  }
                                },
                                label: "User name",
                                prefix: Icons.person),

                                  
                            
      
                                SizedBox(height: 10),
                            defaultTextFormField(
                                controller: EmailController,
                                type: TextInputType.emailAddress,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your email.";
                                  }
                                },
                                label: "Email",
                                prefix: Icons.email),

                                     SizedBox(height: 10),
                            defaultTextFormField(
                                controller: PhoneController,
                                type: TextInputType.phone,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your phone.";
                                  }
                                },
                                label: "Phone number",
                                prefix: Icons.phone),

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
                                  if (FormKey.currentState!.validate()) {
                                    // cubit.UserRegister(
                                    //     phone:PhoneController.text,
                                    //     name:NameController.text,
                                    //     email: EmailController.text,
                                    //     password: PasswordController.text,context: context);
                                  }
                                },
                                label: "Password",
                                prefix: Icons.lock_outline,
                                suffix: cubit.suffix,
                                isPassword:
                                    cubit.isPassword,
                                suffixPressed: () {
                                  cubit.changeSuffix();
                                }),
                            SizedBox(height: 20),
                            ConditionalBuilder(
                                condition: state is !SocialRegisterLoadingState,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (FormKey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context).UserRegister(
                                            name:NameController.text,
                                            email: EmailController.text,
                                            password: PasswordController.text,
                                            phone: PhoneController.text,
                                            );
                                      }
                                    },
                                    text: "Register"),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    )),
                            SizedBox(height: 10),
                            
                          ],
                        ),
                      ))),
            ))
    );
      }, listener: (context,state)
      {
        if (state is SocialCreateUserSuccessState) 
            {
              navigateAndFinish(context, LoginScreen());

            } else 
            {
              
            }
        }
      ), );
    throw UnimplementedError();
  }

}