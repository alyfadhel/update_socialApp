import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/constantse.dart';
import 'package:new_social_app/modules/login/cubit/state.dart';





class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

  void loginUser({
    required String email,
    required String password,
})
  {
    emit(SocialLoginUserLoadingState());
    FirebaseAuth
        .instance
        .signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginUserSuccessState(value.user!.uid));
    }).catchError((error)
    {
      emit(SocialLoginUserErrorState(error.toString()));
      print(error.toString());
    });
  }

}