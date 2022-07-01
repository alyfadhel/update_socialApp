import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_social_app/shared/styles/Iconly-Broken_icons.dart';


Widget buildFormField({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validator,
  required IconData prefix,
  required String label,
  IconData? suffix,
  Function()? suffixOnPressed,
  ValueChanged<String>? onFieldSubmitted,
  bool isPassword = false,
  bool isUpperCase = true,
  double radius = 0.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        label: Text(
            isUpperCase ? label.toUpperCase() : label
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ?
        IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(suffix)) : null,
      ),
    );

///////////////////////////////////////////

Widget buildDefaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  TextStyle? style,
  required onPressedButton,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: TextButton(
        onPressed: onPressedButton,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: style,
        ),
      ),
    );


Widget buildDefaultTextButton({
  bool isUpperCase = true,
  TextStyle? style,
  required onPressedText,
  required String text,
}) =>
    TextButton(
      onPressed: onPressedText,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: style,
      ),
    );

////////////////////////////////////////

Future<dynamic> navigateTo(BuildContext context,
    Widget widget,) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

///////////////////////////////////////////////

Future<dynamic> navigateAndFinish(BuildContext context,
    Widget widget,) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) => false);

void showToast({
  required String text,
  required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastState { success, error, warning }

Color chooseColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.blue;
      break;

    case ToastState.error:
      color = Colors.red;
      break;

    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: ()
        {
          Navigator.pop(context);
        },
        icon: const Icon(Iconly_Broken.Arrow___Left_2,
        ),
      ),
      title: Text(
        title!,
      ),
      titleSpacing: 5.0,
      actions: actions,
    );
