import "package:conditional_builder_null_safety/conditional_builder_null_safety.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:social_app/Cubit/cubit.dart";
import "package:social_app/Cubit/states.dart";
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';

import "../../models/PostModel.dart";

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).userModel != null,
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                          margin: EdgeInsets.all(8),
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image(
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-vector/pink-watercolor-leaves-background_23-2148907681.jpg?w=996&t=st=1665010219~exp=1665010819~hmac=235af36592ad218836f11dd61abad54e888ca499fefd6abdd8039f8f8fe38ec9')),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Homies communicate with homies :)",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              )
                            ],
                          )),
                      // MaterialButton(
                      //   onPressed: () {
                      //     SocialCubit.get(context).getPosts();
                      //   },
                      //   child: Text("Refresh"),
                      // ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPostItem(
                              SocialCubit.get(context).posts[index],
                              context,
                              index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: SocialCubit.get(context).posts.length),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
              fallback: (context) =>
                  (SocialCubit.get(context).posts.length == 0)
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.document_scanner),
                            SizedBox(height: 20),
                            Text("No posts")
                          ],
                        ))
                      : Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
    throw UnimplementedError();
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
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
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 15,
                        )
                      ],
                    ),
                    Text(
                      "${model.datetime}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
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
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 5),
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1,
              ),
            ),
            Text(
              "${model.text}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            /*Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text("#Software",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue)),
                          height: 25,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text("#Software",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue)),
                          height: 25,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text("#Software",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue)),
                          height: 25,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text("#Software",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue)),
                          height: 25,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text("#Software",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue)),
                          height: 25,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text("#Software",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue)),
                          height: 25,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/

            if (model.postImage != "")
              Padding(
                padding: EdgeInsetsDirectional.only(top: 15),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('${model.postImage}'))),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            SocialCubit.get(context).likePost(
                                SocialCubit.get(context).postsID[index]);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${SocialCubit.get(context).Likes[index]}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ))),
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  IconBroken.Chat,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '120 Comments',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ))),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, top: 5, left: 0, right: 0),
              child: Container(
                width: double.infinity,
                color: Colors.grey[500],
                height: 1,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Write a comment ...",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                )),
                InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ));
}
