import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/compontents/constantse.dart';
import 'package:new_social_app/layout/social_layout/social_layout.dart';
import 'package:new_social_app/models/SocialUserModel.dart';
import 'package:new_social_app/modules/login/cubit/cubit.dart';
import 'package:new_social_app/modules/login/cubit/state.dart';
import 'package:new_social_app/modules/register/register_screen.dart';
import 'package:new_social_app/shared/network/local/cache_helper.dart';


var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginUserErrorState)
          {
            showToast(text: state.error, state: ToastState.error);
          }
          if(state is SocialLoginUserSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
            {

              navigateAndFinish(context, const SocialLayout());
            });
          }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 30.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Login to communicate with your friends',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                  ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        buildFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                          label: 'email address',
                          radius: 10.0,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        buildFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.lock_open_outlined,
                          label: 'password',
                          radius: 10.0,
                          suffix: cubit.suffix,
                          isPassword: cubit.isPassword,
                          suffixOnPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {

                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginUserLoadingState,
                          builder: (context) => buildDefaultButton(
                            onPressedButton: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            radius: 10.0,
                            style:
                            Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:
                           [
                           Text(
                             'Don\'t have an account ? ',
                             style: Theme.of(context).textTheme.headline6!.copyWith(
                               fontSize: 15.0,
                             ),
                           ),
                           buildDefaultTextButton(
                               onPressedText: ()
                               {
                                 navigateTo(
                                   context,
                                   const SocialRegisterScreen(),
                                 );
                               },
                               text: 'register',
                             style: Theme.of(context).textTheme.headline5!.copyWith(
                               color: Colors.blue,
                             )
                           )
                         ],
                       ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
