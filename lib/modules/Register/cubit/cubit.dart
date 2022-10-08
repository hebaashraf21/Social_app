import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/UserModel.dart';
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
        //print("success");
        //print(value.user!.email);
        emit(SocialRegisterSuccessState());
        CreateUser(
          email: email,
          password: password, 
          name: name,
          phone: phone,
          uID: value.user!.uid,
          image:'https://www.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_18185537.htm#query=person&position=19&from_view=search&track=sph',
          cover:'https://img.freepik.com/free-vector/pink-watercolor-leaves-background_23-2148907681.jpg?w=996&t=st=1665010219~exp=1665010819~hmac=235af36592ad218836f11dd61abad54e888ca499fefd6abdd8039f8f8fe38ec9',
          bio:"Your bio");
      }).catchError((err){
        //print(err.toString());
        print("error");
        emit(SocialRegisterErrorState());
      });
  }

  void CreateUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uID,
    required String image,
    required String cover,
    required String bio,


  })
  {
    //UserModel model=UserModel(email, name, phone, uID,false,image,cover,bio);
    UserModel model=UserModel(email: email,name: name,phone: phone,uID: uID,isEmailVerified: false,image: image,cover: cover,bio: bio);

    FirebaseFirestore.instance
    .collection('users')
    .doc('uID')
    .set(model.toMap())
    .then((value) {emit(SocialCreateUserSuccessState());})
    .catchError((err){
      print(err.toString());
      emit(SocialCreateUserErrorState());});
  }


}