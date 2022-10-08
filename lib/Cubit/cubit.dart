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

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  int currentIndex = 0;
  List<Widget> Screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String> Titles = ['Home', 'Chats', 'Add post', 'Users', 'Settings'];

  bool isDark = true;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.SetData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc('uID')
        .get()
        .then((value) {
      emit(SocialGetUserSuccessState());
      //print("user data");
      //print(value.data());
      userModel = UserModel.fromJson(value.data()!);
    }).catchError((err) {
      print(err.toString());
      emit(SocialGetUserErrorState(err));
    });
  }

  void ChangeNavBar(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavBarState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(CoverImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${userModel!.uID}')
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print("value:$profileImageUrl");
        emit(ProfileImagePickedSuccessState());
      }).catchError((err) {
        emit(ProfileImagePickedErrorState());
      });
    }).catchError(() {
      emit(ProfileImagePickedErrorState());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${userModel!.uID}')
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        print("value:$coverImageUrl");
        emit(CoverImagePickedSuccessState());
      }).catchError((err) {
        emit(CoverImagePickedErrorState());
      });
    }).catchError(() {
      emit(CoverImagePickedErrorState());
    });
  }

  void updateUserImages({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserLoadingState());

    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null && profileImage != null) {
      uploadCoverImage();
      uploadProfileImage();
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    UserModel model = UserModel(
        uID: userModel!.uID,
        name: name,
        phone: phone,
        bio: bio,
        isEmailVerified: false,
        image: userModel!.image,
        cover: userModel!.cover,
        email: userModel!.email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID!)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UpdateUserSuccessState());
    }).catchError(() {
      emit(UpdateUserErrorState());
    });
  }
}
