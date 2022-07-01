import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/cubit/states.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel!;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: coverImage == null ?  NetworkImage(
                  userModel.cover!,
              ) : FileImage(coverImage) as ImageProvider,
            ),
          ),
          width: double.infinity,
          height: 250.0,
          padding: const EdgeInsets.only(
            top: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100.0,
              ),
              CircleAvatar(
                radius: 41,
                backgroundColor:
                Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: profileImage == null
                      ? NetworkImage(
                    userModel.image!,
                  )
                      : FileImage(profileImage) as ImageProvider,
                ),
              ),
               Text(
                userModel.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                userModel.bio!,
                style:  TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
