import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:social_app/Cubit/cubit.dart";
import 'package:social_app/shared/components/components.dart';

import "../../Cubit/states.dart";
import '../../styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Add post'),
              titleSpacing: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2)),
              actions: [
                TextButton(
                    onPressed: () {
                      if (cubit.postImage == null) {
                        cubit.createPost(
                            text: textController.text,
                            datetime: DateTime.now().toString());
                      } else {
                        cubit.uploadPostImage(
                            datetime: DateTime.now().toString(),
                            text: textController.text);
                      }
                    },
                    child: Text(
                      "POST",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is CreatePostLoadingState)
                    LinearProgressIndicator(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-vector/blurred-background-with-hello-springtime-lettering_23-2148427181.jpg?w=996&t=st=1665013218~exp=1665013818~hmac=1f135c73811dfd611200e20a5f2f9f68c9b587d6c55f09ccc526725649244d85'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          "heba ashraf",
                          style: TextStyle(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText:
                            "What's on your mind ${SocialCubit.get(context).userModel!.name} ...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(cubit.postImageFile!)
                                      as ImageProvider)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                cubit.getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconBroken.Image),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Add image"),
                                ],
                              ))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("#tags"),
                                ],
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
    throw UnimplementedError();
  }
}
