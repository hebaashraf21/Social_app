import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Cubit/states.dart';
import 'package:social_app/models/UserModel.dart';
import 'package:social_app/modules/Chats/ChatsScreen.dart';
import 'package:social_app/modules/Feeds/FeedsScreen.dart';
import 'package:social_app/modules/Settings/SettingsScreen.dart';
import 'package:social_app/modules/Users/UsersScreen.dart';

import '../modules/NewPost/NewPostScreen.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit():super(SocialInitialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

   UserModel? userModel;
   int currentIndex=0;
   List<Widget>Screens=[FeedsScreen(),ChatsScreen(),NewPostScreen(),UsersScreen(),SettingsScreen()];
   List<String>Titles=['Home','Chats','Add post','Users','Settings'];

   bool isDark=true;  

  void changeMode( {bool? fromShared})
  {
    if(fromShared!=null)
    {
      isDark=fromShared;
      emit(ChangeModeState());
    }
    else{

      isDark=!isDark;
      CacheHelper.SetData(key: 'isDark',value: isDark).then((value) {
      emit(ChangeModeState());
      
    });
    }
    
    
    
    
  }

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
        userModel=UserModel.fromJson(value.data()!);
      })
    .catchError(
      (err){
        print(err.toString());
        emit(SocialGetUserErrorState(err));
      });
  }

  void ChangeNavBar(int index)
  {
    
    if(index==2)
    {
      emit(SocialNewPostState());
    }
    else
    {
      currentIndex=index;
      emit(SocialChangeBottomNavBarState());

    }

  }


  File? profileImage;
  var picker=ImagePicker();

  Future<void> getProfileImage()async
  {
    final pickedFile= await picker.getImage(source: ImageSource.gallery);

    if(pickedFile!=null)
    {
      profileImage=File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());

    }
    else
    {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }

  }

   File? coverImage;

  Future<void> getCoverImage()async
  {
    final pickedFile= await picker.getImage(source: ImageSource.gallery);

    if(pickedFile!=null)
    {
      coverImage=File(pickedFile.path);
      emit(CoverImagePickedSuccessState());

    }
    else
    {
      print('No image selected');
      emit(CoverImagePickedErrorState());
    }

  }


}