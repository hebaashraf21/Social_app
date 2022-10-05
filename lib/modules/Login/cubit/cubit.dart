import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit():super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.remove_red_eye_outlined;
  bool isPassword=true;

  void changeSuffix()
  {
    isPassword=!isPassword;
    suffix=(isPassword)?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(SocialLoginChangePasswordVisibility());
  }
  

  void UserLogin({
    required String email,
    required String password
  })
  {
    emit(SocialloginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => print(value.user!.email)).catchError((onError){print(onError.toString());});
  }


}