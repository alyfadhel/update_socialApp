import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/cubit/states.dart';
import 'package:new_social_app/layout/social_layout/my_header_drawer.dart';
import 'package:new_social_app/modules/add_post/add_posts-screen.dart';
import 'package:new_social_app/modules/notification/notification_screen.dart';
import 'package:new_social_app/modules/profile/profile_screen.dart';
import 'package:new_social_app/modules/search/search_screen.dart';
import 'package:new_social_app/shared/styles/Iconly-Broken_icons.dart';
import 'package:new_social_app/shared/styles/cubit/cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {
        if(state is SocialAddPost)
        {
          navigateTo(context, const AddPostsScreen());
        }
      },
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions:
            [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, const NotificationScreen());
                },
                icon: const Icon(
                    Iconly_Broken.Notification,
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, const SearchScreen(),);
                },
                icon: const Icon(
                    Iconly_Broken.Search,
                ),
              ),
            ],
          ),
          drawer: Drawer(
            width: 250.0,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MyHeaderDrawer(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  myDrawerList(context),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: cubit.items,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }

  Widget myDrawerList(context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Themes',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Spacer(),
                IconButton(
                  onPressed: ()
                  {
                    ThemeCubit.get(context).changeMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Spacer(),
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, const ProfileScreen());
                  },
                  icon: const Icon(
                    Iconly_Broken.Profile,
                  ),
                ),

              ],
            ),
          ],
        ),
  );
}
