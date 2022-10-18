import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../modules/Login/LoginScreen.dart';
import '../network/local/cache_helper.dart';

Widget defaultAppBar({
  required BuildContext context,
  List<Widget>? actions,
  String? title,
}) =>
    AppBar(
      title: Text(title!),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconBroken.Arrow___Left_2)),
      actions: actions,
    );

Future<bool?> showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  late Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void SignOut(context) {
  CacheHelper.RemoveData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  GestureTapCallback? ontap,
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  bool isClickable = true,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      //onFieldSubmitted:(s){onSubmit();} ,
      //onChanged:(s) {onChange!();},
      enabled: isClickable,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget myDivider() => Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );

Widget defaultButton({
  double width = double.infinity,
  //Color background =defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: primary,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Lobster'),
        ),
      ),
    );

Widget defaultTextButton({
  required Function ontap,
  required String text,
}) {
  return TextButton(
      onPressed: () {
        ontap;
      },
      child: Text("$text"));
}

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model!.image),
                  height: 120,
                  width: 120,
                ),
                model.discount != 0 && isOldPrice
                    ? Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, height: 1.3, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      model.discount != 0 && isOldPrice
                          ? Text(
                              model.oldPrice.toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            )
                          : Container(),
                      const Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     SocialCubit.get(context)
                      //         .changeFavorites(model.id);
                      //   },
                      //   icon: SocialCubit.get(context)
                      //       .favorites[model.id] ==
                      //       true
                      //       ? const Icon(
                      //     Icons.favorite,
                      //     color: Color.fromARGB(255, 117, 79, 178),
                      //   )
                      //       : const Icon(
                      //     Icons.favorite_border,
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
