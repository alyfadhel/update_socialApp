import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/cubit/states.dart';
import 'package:new_social_app/models/SocialUserModel.dart';
import 'package:new_social_app/modules/chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(context,SocialCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 15.0,
                end: 15.0,
              ),
              child: Divider(
                height: 1.0,
                color: Colors.grey[200],
              ),
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context,SocialUserModel model) => InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              model.image!,
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            model.name!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 13.0,
              fontWeight: FontWeight.normal,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

}
