import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/states.dart';
import 'package:social_app/modules/NewPost/NewPostScreen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';

class Layout extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
    (
      builder: (context,state)
      {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search))],
          ),
      body: cubit.Screens[cubit.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currentIndex,
        onTap: (Value){cubit.ChangeNavBar(Value);},
        items: [
          BottomNavigationBarItem(icon: Icon(IconBroken.Home),label:"Home"),
          BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: "Chats"),
          BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: "Post"),
          BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: "Users"),
          BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: "Settings")
        ]),
    );
      },
       listener: (context,state)
       {
        if(state is SocialNewPostState)
        {
          navigateTo(context, NewPostScreen());
        }
       });
    throw UnimplementedError();
  }
  
}