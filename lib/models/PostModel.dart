class PostModel {
  String? name;
  String? uID;
  String? image;
  String? datetime;
  String? text;
  String? postImage;

  PostModel(
      {this.name,
      this.uID,
      this.image,
      this.datetime,
      this.text,
      this.postImage});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uID = json['uID'];
    image = json['image'];
    datetime = json['datetime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uID': uID,
      'image': image,
      'datetime': datetime,
      'text': text,
      'postImage': postImage
    };
  }
}
