import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/modules/Layout/Layout.dart';
import 'package:social_app/modules/Login/LoginScreen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/bloc_observer.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/styles/Themes.dart';

import 'Cubit/states.dart';
import 'modules/Register/RegisterScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey:
        'recaptcha-v3-site-key', // If you're building a web app.
  );

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  uID = CacheHelper.GetData(key: 'uID');
  bool? isDark = CacheHelper.GetData(key: 'isDark');
  print(uID);

  runApp(MyApp(uID, isDark));
}

class MyApp extends StatelessWidget {
  var uID;
  final bool? isDark;
  MyApp(this.uID, this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()
              ..changeMode(fromShared: isDark),
          ),
        ],
        child: BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                  // theme: SocialCubit.get(context).isDark
                  //       ? Darktheme
                  //       : LightTheme,
                  theme: LightTheme,
                  debugShowCheckedModeBanner: false,
                  home: LoginScreen()
                  //(uID==null)?LoginScreen():Layout()

                  );
            }));
  }
}
