import 'package:flutter/material.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/modules/login/login_screen.dart';
import 'package:new_social_app/shared/network/local/cache_helper.dart';

 dynamic uId = " " ;


void signOut(context)
{
  CacheHelper.removeData(key: 'uId').then((value)
  {
    if(value)
    {
      navigateAndFinish(context,  const SocialLoginScreen(),);
    }
  });
}