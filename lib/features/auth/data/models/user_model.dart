import '../../domain/entities/user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required String uid,
    String? email,
    String? name,
    String? pictureUrl,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          pictureUrl: pictureUrl,
        );

  factory AppUserModel.fromJson(Map<String, dynamic> json) => AppUserModel(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        pictureUrl: json['pictureUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'pictureUrl': pictureUrl,
    };
  }
}
