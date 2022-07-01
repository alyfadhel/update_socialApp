import 'package:flutter/material.dart';
import 'package:new_social_app/models/SocialUserModel.dart';
class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel? userModel;
  const ChatDetailsScreen({this.userModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children:
           [
             CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  userModel!.image!,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              userModel!.name!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14.0,
              ),
            )
          ],
        ),
      ),
      extendBodyBehindAppBar: false,

      body: Column(
        children:
        [
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart:  Radius.circular(10.0),
                topEnd:   Radius.circular(10.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: const Text(
              'Hello World',
            ),
          ),
        ],
      ),
    );
  }
}
