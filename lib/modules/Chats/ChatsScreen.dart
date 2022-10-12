import "package:conditional_builder_null_safety/conditional_builder_null_safety.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:social_app/modules/ChatDetails/ChatDetailsScreen.dart";
import "package:social_app/shared/components/components.dart";

import "../../Cubit/cubit.dart";
import "../../Cubit/states.dart";
import "../../models/UserModel.dart";

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).users.length > 0 &&
                  SocialCubit.get(context).userModel != null,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatItem(
                      SocialCubit.get(context).userModel!, context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: SocialCubit.get(context).users.length),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) {});
    throw UnimplementedError();
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: (() {
          navigateTo(context, ChatDetailsScreen(model));
        }),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${model.name}",
                        style: TextStyle(height: 1.4),
                      ),
                    ],
                  ),
                ],
              )),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ))
            ],
          ),
        ),
      );
}
