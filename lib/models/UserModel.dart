class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uID;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;

  UserModel({this.email,this.name,this.phone,this.uID,this.isEmailVerified,this.image,this.cover,this.bio});

  UserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uID=json['uID'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
  }

  Map<String,dynamic>toMap()
  {
    return
    {
      'name':name,
      'email':email,
      'phone':phone,
      'uID':uID,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'cover':cover,
      'bio':'bio'

    };
  }

}