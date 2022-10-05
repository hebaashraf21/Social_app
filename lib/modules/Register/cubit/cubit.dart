import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Login/LoginScreen.dart';
import 'package:social_app/modules/Register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import '../../../shared/network/end_points.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.remove_red_eye_outlined;
  bool isPassword=true;


  void changeSuffix()
  {
    isPassword=!isPassword;
    suffix=(isPassword)?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }
  

  void UserRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then(
      (value) {
        print("success");
        print(value.user!.email);
        emit(SocialRegisterSuccessState());
      }).catchError((err){
        print(err.toString());
        print("error");
        emit(SocialRegisterErrorState());
      });
  }


}