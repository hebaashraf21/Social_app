import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:social_app/Cubit/cubit.dart";
import "package:social_app/Cubit/states.dart";
import "package:social_app/models/UserModel.dart";
import "package:social_app/styles/icon_broken.dart";

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatDetailsScreen(this.model);
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${model.image}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("${model.name}"),
                ]),
              ),
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    buildRecieverMessage(),
                    buildMyMessage(),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message here...'),
                          )),
                          Container(
                            height: 40,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                    recieverId: model.uID!);
                              },
                              child: Icon(
                                IconBroken.Send,
                                size: 16,
                                color: Colors.white,
                              ),
                              minWidth: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
        listener: (context, state) {});
    throw UnimplementedError();
  }

  Widget buildRecieverMessage() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10))),
          child: Text("mmm"),
        ),
      );

  Widget buildMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.7),
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10))),
          child: Text("mmm"),
        ),
      );
}
