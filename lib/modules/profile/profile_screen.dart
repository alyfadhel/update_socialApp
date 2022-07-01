import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/compontents/constantse.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/cubit/states.dart';
import 'package:new_social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:new_social_app/shared/network/local/cache_helper.dart';
import 'package:new_social_app/shared/styles/Iconly-Broken_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Profile',
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // if(model.userModel == null)
                  Container(
                    height: 340.0,
                    alignment: AlignmentDirectional.topStart,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 280.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  4.0,
                                ),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  userModel!.cover!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              userModel.image!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    userModel.name!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14.0,
                        ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    userModel.bio!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text('100',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(
                                  'post',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text('265',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(
                                  'Photos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text('95',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(
                                  'Followers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text('65',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(
                                  'Following',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            'Add Photos',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(context, const EditProfileScreen());
                        },
                        child: const Icon(
                          Iconly_Broken.Edit,
                          size: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            signOut(context);
                          },
                          child: const Icon(Iconly_Broken.Logout),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
