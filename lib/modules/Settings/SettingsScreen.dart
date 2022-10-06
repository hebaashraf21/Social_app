import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/states.dart';
import 'package:social_app/modules/EditProfile/EditProfileScreen.dart';
import 'package:social_app/shared/components/components.dart';

import '../../styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (context,state)
      {
        var userModel=SocialCubit.get(context).userModel;
        return Padding(padding: EdgeInsets.all(8),
    child: Column
    (
      children: [
        Container(
          height: 190,
          child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child:            Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only
                          (
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${userModel!.cover}'))),
                    ),
            ),
 

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),

                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    '${userModel.image}'),
                              ),
                )
              )      
          ],
        ),
        ),

        SizedBox(height:10),

        Text('${userModel.name}',style: Theme.of(context).textTheme.bodyText1,),

        SizedBox(height:8),

        Text('${userModel.bio}',style: Theme.of(context).textTheme.caption,),

        Padding(padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
              children: [
                Text('100',style: Theme.of(context).textTheme.subtitle2,),
                Text('Posts',style: Theme.of(context).textTheme.caption,)
              ],
            ),
              )),
              Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
              children: [
                Text('200',style: Theme.of(context).textTheme.subtitle2,),
                Text('Photos',style: Theme.of(context).textTheme.caption,)
              ],
            ),
              )),
              Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
              children: [
                Text('2000',style: Theme.of(context).textTheme.subtitle2,),
                Text('Followers',style: Theme.of(context).textTheme.caption,)
              ],
            ),
              )),
              Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
              children: [
                Text('500',style: Theme.of(context).textTheme.subtitle2,),
                Text('Followings',style: Theme.of(context).textTheme.caption,)
              ],
            ),
              )),

          ],),),

          Row(
            children: [
              Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Add photos'))),
              SizedBox(width: 8,),
              OutlinedButton(onPressed: (){navigateTo(context, EditProfileScreen());}, child: Icon(IconBroken.Edit,size: 17,))
            ],
          )
      ],

    ),);
      },
       listener: (context,state){});
    throw UnimplementedError();
  }

}