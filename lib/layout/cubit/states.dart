import 'package:new_social_app/models/SocialUserModel.dart';

abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialChangeBottomNav extends SocialStates{}

class SocialAddPost extends SocialStates{}

class SocialGetUserDataLoadingState extends SocialStates{}

class SocialGetUserDataSuccessState extends SocialStates{}

class SocialGetUserDataErrorState extends SocialStates
{
  final String error;

  SocialGetUserDataErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}


class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates {}



class SocialCoverPickedSuccessState extends SocialStates{}

class SocialCoverPickedErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}
class SocialUserUpdateErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates {}


class SocialRemovePostImageState extends SocialStates{}


class SocialUpdatePostsErrorState extends SocialStates{}

class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates
{
  final String error;
  SocialLikePostErrorState(this.error);
}