import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/compontents/constantse.dart';
import 'package:new_social_app/layout/cubit/states.dart';
import 'package:new_social_app/models/MessageModel.dart';
import 'package:new_social_app/models/PostModel.dart';
import 'package:new_social_app/models/SocialUserModel.dart';
import 'package:new_social_app/modules/add_post/add_posts-screen.dart';
import 'package:new_social_app/modules/chat_details/chat_details_screen.dart';
import 'package:new_social_app/modules/chats/chats_screen.dart';
import 'package:new_social_app/modules/feeds/feeds_screen.dart';
import 'package:new_social_app/modules/profile/profile_screen.dart';
import 'package:new_social_app/modules/users/users_screen.dart';
import 'package:new_social_app/shared/styles/Iconly-Broken_icons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(
        Iconly_Broken.Home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Iconly_Broken.Chat,
      ),
      label: 'Chat',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Iconly_Broken.Paper_Upload,
      ),
      label: 'Add Post',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Iconly_Broken.User,
      ),
      label: 'Users',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(
    //     Iconly_Broken.Setting,
    // ),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const AddPostsScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chat',
    'Add Post',
    'Users',
  ];

  changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialAddPost());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).snapshots()
        .listen((value) {
      userModel = null;
      userModel = SocialUserModel.fromJson(value.data());
      //print(value.data());
      emit(SocialGetUserDataSuccessState());
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverPickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverPickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else
  //   {
  //     updateUser(
  //         name: name,
  //         phone: phone,
  //         bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePost() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      updateUser(
        name: userModel!.name!,
        phone: userModel!.phone!,
        bio: userModel!.bio!,
      );
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  PostModel? postModel;

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts({
    String? dateTime,
    String? text,
  }) {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').snapshots().listen((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
      });
      // updatePost();
      emit(SocialGetPostsSuccessState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
        value.docs.forEach((element) {

          if(element.data()['uId'] != userModel!.uId)
          {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        // updatePost();
        emit(SocialGetAllUserSuccessState());
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
})
  {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      senderId: userModel!.uId,
      dateTime: dateTime,
      text: text,
    );
    FirebaseFirestore.instance.collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

  }


  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
        messages = [];

        event.docs.forEach((element) {
          messages.add(MessageModel.fromJson(element.data()));
        });
        emit(SocialGetMessagesSuccessState());
    });
  }
}
