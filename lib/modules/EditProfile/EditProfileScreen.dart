import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

import '../../styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget
{
  var nameController=TextEditingController();
  var bioController=TextEditingController();

  
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
    (builder: (context,state)
    {
      var userModel=SocialCubit.get(context).userModel;
      var profileImage=SocialCubit.get(context).profileImage;
      var coverImage=SocialCubit.get(context).coverImage;

      nameController.text=userModel!.name!;
      bioController.text=userModel!.bio!;

      return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(IconBroken.Arrow___Left_2)),
        title:Text('Edit your profile'),
        titleSpacing: 0,
        actions: [
          defaultTextButton(ontap: (){}, text: 'UPDATE'),
          SizedBox(width:15)],
      ),

      body:Padding(padding: EdgeInsets.all(10),
      child:      Column(
        children: [
           Container(
          height: 190,
          child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                   Container(
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
                              image: coverImage==null?NetworkImage(
                                  '${userModel!.cover}'):FileImage(coverImage)as ImageProvider)),
                    ),

                   Padding(padding: EdgeInsets.all(10),
                   child:  CircleAvatar(
                    child: IconButton(onPressed: (){SocialCubit.get(context).getCoverImage();}, icon: Icon(IconBroken.Camera,size: 20,),),backgroundColor: Colors.blue,) ,)
                ],
              )
            ),
 

             Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),

                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                  radius: 65,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage==null ? NetworkImage('${userModel.image}'):FileImage(profileImage) as ImageProvider,
                              ),
                ),
                 CircleAvatar(child: IconButton(onPressed: (){SocialCubit.get(context).getProfileImage();}, icon: Icon(IconBroken.Camera,size: 20,),),backgroundColor: Colors.blue,)
                  ],
                )
                
              ),
          ],
        ),
        ),

        SizedBox(height:20),

        defaultTextFormField(
          controller: nameController,
          type: TextInputType.name,
          validate: (value)
          {
            if(value.isEmpty)
            {
              return 'Please enter your name';
            }
            else
            return null;
          }, label: 'Name', prefix: IconBroken.User),


          SizedBox(height:10),

          defaultTextFormField(
          controller: bioController,
          type: TextInputType.text,
          validate: (value)
          {
            if(value.isEmpty)
            {
              return 'Please enter your bio';
            }
            else
            return null;
          }, label: 'Bio', prefix: IconBroken.Info_Circle),

        
        ],
      ))
    );
    }, listener: (context,state){});
    throw UnimplementedError();
  }

}