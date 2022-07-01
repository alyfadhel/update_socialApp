abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class ChangePasswordVisibilityState extends SocialLoginStates{}


class SocialLoginUserLoadingState extends SocialLoginStates{}
class SocialLoginUserSuccessState extends SocialLoginStates
{
  final String uId;

  SocialLoginUserSuccessState(this.uId);
}
class SocialLoginUserErrorState extends SocialLoginStates
{
  final String error;

  SocialLoginUserErrorState(this.error);
}