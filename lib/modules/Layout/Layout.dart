import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

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
            title: Text("Home"),
          ),
      body: ConditionalBuilder(
        condition: cubit.model !=null,
        builder: (context)=>Column(
        children: [
          if(FirebaseAuth.instance.currentUser!.emailVerified==false)
          Container(
            color: Colors.amber.withOpacity(0.5),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Row(
            children: [
              Icon(Icons.warning),
              SizedBox(width:15),
              Expanded(child: Text("Please verify email"),),
              SizedBox(width:20),
              TextButton(
                onPressed: ()
                {
                  FirebaseAuth.instance
                  .currentUser?.sendEmailVerification()
                  .then((value) 
                  {
                    showToast(text: 'Check your Email', state: ToastState.SUCCESS);
                  })
                  .catchError((err)
                  {
                    print(err.toString());
                    //showToast(text: text, state: ToastState.ERROR);
                  });

              }, child: Text("Send"))
              
            ],
          ),)
          )
        ],
      ),
        fallback: (context)=>Center(child: CircularProgressIndicator(),))
    );
      },
       listener: (context,state){});
    throw UnimplementedError();
  }
  
}