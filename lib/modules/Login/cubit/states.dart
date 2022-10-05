abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}
class SocialloginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates
{
  String uId;
  SocialLoginSuccessState(this.uId);
 
}

class SocialLoginErrorState extends SocialLoginStates
{

}

class SocialLoginChangePasswordVisibility extends SocialLoginStates{}