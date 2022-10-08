abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavBarState extends SocialStates{}

class ChangeModeState extends SocialStates{}

class SocialNewPostState extends SocialStates{}


class ProfileImagePickedSuccessState extends SocialStates{}

class ProfileImagePickedErrorState extends SocialStates{}

class CoverImagePickedSuccessState extends SocialStates{}

class CoverImagePickedErrorState extends SocialStates{}

class UpdateUserLoadingState extends SocialStates {}

class UpdateUserSuccessState extends SocialStates {}

class UpdateUserErrorState extends SocialStates {}
