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
