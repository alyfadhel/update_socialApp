import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/models/SocialUserModel.dart';
import 'package:new_social_app/modules/register/cubit/state.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

  SocialUserModel? userModel;

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
})
  {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        cover: "https://img.freepik.com/free-photo/photo-worried-curly-haired-young-woman-feels-stressed-nervous-bites-finger-nails-wears-spectacles-casual-turtleneck-isolated-red-background-reacts-scary-news-human-reactions_273609-61407.jpg?w=740",
        image: "https://img.freepik.com/free-photo/outdoor-shot-positive-woman-with-curly-hair-smiles-gladfully-wears-spectacles-casual-shirt-vest-spends-weekend-walking-outside-poses-city-has-good-mood-people-lifestyle-concept_273609-62277.jpg?w=900",
        bio: "write your bio ...",
    );
    emit(SocialCreateUserLoadingState());
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId.toString())
        .set(model.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit(SocialRegisterUserLoadingState());
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      print(value.user!.phoneNumber);
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      //emit(SocialRegisterUserSuccessState());
    }).catchError((error)
    {
      emit(SocialRegisterUserErrorState(error.toString()));
      print(error.toString());
    });
  }

}