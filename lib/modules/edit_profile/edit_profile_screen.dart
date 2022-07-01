import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/cubit/states.dart';
import 'package:new_social_app/shared/styles/Iconly-Broken_icons.dart';

var nameController = TextEditingController();
var phoneController = TextEditingController();
var bioController = TextEditingController();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel!;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 340.0,
                    alignment: AlignmentDirectional.topStart,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
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
                                    image: coverImage == null
                                        ? NetworkImage(
                                            userModel.cover!,
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 18.0,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: const Icon(
                                      Iconly_Broken.Camera,
                                      size: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        userModel.image!,
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    Iconly_Broken.Camera,
                                    size: 17.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                OutlinedButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                    );
                                  },
                                  child: const Text(
                                    'Upload Image',
                                  ),
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                OutlinedButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                    );
                                  },
                                  child: const Text(
                                    'Cover Image',
                                  ),
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  buildFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    prefix: Iconly_Broken.User,
                    label: 'name',
                    radius: 10,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    prefix: Iconly_Broken.Info_Circle,
                    label: 'bio',
                    radius: 10,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    prefix: Iconly_Broken.Call,
                    label: 'phone',
                    radius: 10,
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
