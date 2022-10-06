import 'package:flutter/material.dart';
import 'package:social_app/shared/components/components.dart';

import '../../styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
(
  title: Text('Add post'),
  titleSpacing: 0,
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    }, icon: Icon(IconBroken.Arrow___Left_2)),

)
      
    );
    throw UnimplementedError();
  }

}