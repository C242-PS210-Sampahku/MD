class UserModel {

  final String? userId;
  final String? name;
  final String? username;
  final String? email;
  final String? password;
  final String? gender;
  final String? token;
  final String? noHp;
  final String? imgUrl;

  UserModel({
     this.userId,
     this.name,
     this.username,
     this.email,
     this.password,
     this.gender,
     this.token,
     this.noHp,
     this.imgUrl,
  });

  
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      userId: data['user_id'] as String,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      gender: data['gender'] ?? '',
      token: data['token'] ?? '',
      noHp: data['no_hp'] ?? '',
      imgUrl: data['img_url'] ?? '',
    );
  }

  
  Map<String, String> toJson() {
    return {
      'user_id': userId ?? "",
      'name': name ?? "",
      'username': username ?? "",
      'email': email ?? "",
      'password': password ?? "",
      'gender': gender ?? "",
      'token': token ?? "",
      'no_hp': noHp ?? "",
      'img_url': imgUrl ?? "",
    };
  }
}
