import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/layout/social_layout/social_layout.dart';
import 'package:new_social_app/modules/register/cubit/cubit.dart';
import 'package:new_social_app/modules/register/cubit/state.dart';



var nameController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var phoneController = TextEditingController();
var formKey = GlobalKey<FormState>();

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context, const SocialLayout());
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 30.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Register to communicate with your friends',
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
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.person_outline_outlined,
                          label: 'name',
                          radius: 10.0,
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
                        buildFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          prefix: Icons.phone_android_outlined,
                          label: 'phone',
                          radius: 10.0,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterUserLoadingState,
                          builder: (context) => buildDefaultButton(
                            onPressedButton: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            radius: 10.0,
                            style:
                            Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
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
