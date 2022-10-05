class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uID;
  bool? isEmailVerified;

  UserModel(this.email,this.name,this.phone,this.uID,this.isEmailVerified);

  UserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uID=json['uID'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String,dynamic>toMap()
  {
    return
    {
      'name':name,
      'email':email,
      'phone':phone,
      'uID':uID,
      'isEmailVerified':isEmailVerified

    };
  }

}