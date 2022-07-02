import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/cubit/states.dart';
import 'package:new_social_app/models/SocialUserModel.dart';
import 'package:new_social_app/shared/styles/Iconly-Broken_icons.dart';

var textController = TextEditingController();
class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel? userModel;
  const ChatDetailsScreen({this.userModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
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

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                buildMessage(),
                buildMyMessage(),
                const Spacer(),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0
                          ),
                          child: TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here ....',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: Colors.blue,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: ()
                          {
                            SocialCubit.get(context).sendMessage(
                                receiverId: userModel!.uId!,
                                dateTime: DateTime.now().toString(),
                                text: textController.text,
                            );
                          },
                          child: const Icon(
                            Iconly_Broken.Send,
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildMessage() => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  BoxDecoration(
        color: Colors.deepOrange.withOpacity(.5),
        borderRadius: const BorderRadiusDirectional.only(
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
  );
  Widget buildMyMessage() => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:  BoxDecoration(
        color: Colors.blue.withOpacity(.5),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
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
  );
}
