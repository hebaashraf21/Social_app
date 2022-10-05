import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/states.dart';
import 'package:social_app/models/UserModel.dart';

import '../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit():super(SocialInitialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

   UserModel? model;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
    .collection('users')
    .doc('uID')
    .get()
    .then(
      (value) 
      {
        emit(SocialGetUserSuccessState());
        //print("user data");
        //print(value.data());
        model=UserModel.fromJson(value.data()!);
      })
    .catchError(
      (err){
        print(err.toString());
        emit(SocialGetUserErrorState(err));
      });
  }


}