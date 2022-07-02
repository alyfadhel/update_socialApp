
class SocialUserModel
{
  late String? name;
  late String? email;
  late String? phone;
  late String? uId;
  late String? cover;
  late String? image;
  late String? bio;

  SocialUserModel(
      {
       required this.name,
       required this.email,
       required this.phone,
       required this.uId,
       required this.cover,
       required this.image,
       required this.bio,
      });

  SocialUserModel.fromJson(Map<String,dynamic>?json)
  {
    name = json?['name']??'';
    email = json?['email']??'';
    phone = json?['phone']??'';
    uId = json?['uId']??'';
    cover = json?['cover']??'';
    image = json?['image']??'';
    bio = json?['bio']??'';

  }

  Map<String,dynamic>toMap()
  {
    return
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
        'uId' : uId,
        'cover' : cover,
        'image' : image,
        'bio' : bio,
      };
  }

}