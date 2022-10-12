import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Cubit/states.dart';
import "package:social_app/models/MessageModel.dart";
import 'package:social_app/models/UserModel.dart';
import 'package:social_app/modules/Chats/ChatsScreen.dart';
import 'package:social_app/modules/Feeds/FeedsScreen.dart';
import 'package:social_app/modules/Settings/SettingsScreen.dart';
import 'package:social_app/modules/Users/UsersScreen.dart';

import "../models/PostModel.dart";
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
        .doc(uID)
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
    if (index == 1) getAllUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavBarState());
    }
  }

  XFile? profileImage;
  File? profileImageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    profileImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (profileImage != null) {
      profileImageFile = File(profileImage!.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(ProfileImagePickedErrorState());
    }
  }

  XFile? coverImage;
  File? coverImageFile;
  Future<void> getCoverImage() async {
    coverImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (coverImage != null) {
      coverImageFile = File(coverImage!.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(CoverImagePickedErrorState());
    }
  }

  String profileImageUrl = "";
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImageFile!) //image waslet el storage
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          profileImageUrl = value;
          updateUser(
            name: name,
            phone: phone,
            bio: bio,
            image: value,
          );
        },
      ).catchError(
        (error) {
          emit(ProfileImagePickedSuccessState());
        },
      );
    }).catchError(
      (error) {
        print(error.toString());
        emit(ProfileImagePickedErrorState());
      },
    );
  }

  String coverImageUrl = "";
  void uplaodCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImageFile!) //image waslet el storage
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        print(error);
        emit(CoverImagePickedSuccessState());
      });
    }).catchError((error) {
      print(error);
      emit(CoverImagePickedErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(UpdateUserLoadingState());

  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //     uploadCoverImage();
  //     uploadProfileImage();
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      String? image,
      String? cover}) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
        uID: uID,
        name: name,
        phone: phone,
        bio: bio,
        isEmailVerified: false,
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        email: userModel!.email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UpdateUserSuccessState());
    }).catchError(() {
      emit(UpdateUserErrorState());
    });
  }

  XFile? postImage;
  File? postImageFile;
  Future<void> getPostImage() async {
    postImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (postImage != null) {
      postImageFile = File(postImage!.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(PostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String? datetime,
    required String? text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          datetime: datetime,
          text: text,
          postImage: value,
        );
        //emit(SocialUploadPostImageSuccessStates());
      }).catchError((error) {
        emit(UploadImagePostErrorState());
      });
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  void createPost({
    String? postImage,
    required String? text,
    required String? datetime,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
      image: userModel!.image,
      name: userModel!.name,
      uID: userModel!.uID,
      datetime: datetime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    postImageFile = null;
    emit(RemovePostImage());
  }

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> Likes = [];
  List<UserModel> users = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      emit(SocialGetPostsSuccessState());
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          Likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsID.add(element.id);
        }).catchError(onError);
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error));
    });
  }

  void likePost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel!.uID)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error));
    });
  }

  void getAllUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      emit(SocialGetAllUsersSuccessState());
      value.docs.forEach((element) {
        if (element['uID'] != userModel!.uID)
          users.add(UserModel.fromJson(element.data()));
          print("users...$users");
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error));
    });
  }


  void sendMessage({
    required String text,
    required String dateTime,
    required String recieverId
  })
  {
    MessageModel model=MessageModel(
      text: text,senderId: userModel!.uID,dateTime: dateTime,recieverId: recieverId
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uID)
    .collection('chats')
    .doc(recieverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(SendMessageSuccessState());
    })
    .catchError((error){
      emit(SendMessageErrorState());
    });


    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

  }


  List<MessageModel>messages=[];

  void getMessages({
    required String recieverId
  })
  {
    messages=[];
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uID)
    .collection('chats')
    .doc(recieverId)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots().listen((event) {
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
    emit(GetMessageSuccessState());

  }
}
