

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates
{

  SocialRegisterSuccessState();
}

class SocialRegisterErrorState extends SocialRegisterStates
{

}

class SocialCreateUserSuccessState extends SocialRegisterStates
{

  SocialCreateUserSuccessState();
}

class SocialCreateUserErrorState extends SocialRegisterStates
{

}


class SocialRegisterChangePasswordVisibility extends SocialRegisterStates{}