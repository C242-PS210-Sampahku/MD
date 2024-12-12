
class LoginResponse {
  bool success;
  String? message;
  UserData? data;

  LoginResponse({
    required this.success,
    this.message,
    this.data,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success']??json['status'] ?? false,
      message: json['message']?? "",
      data: json["data"] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  
}

class UserData {
  final User? user;

  UserData({this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(user: User.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user!.toJson(),
    };
  }
}

class User {
  final String uid;
  final String email;
  final bool emailVerified;
  final bool isAnonymous;
  final List<ProviderData> providerData;
  final StsTokenManager stsTokenManager;

  User({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.isAnonymous,
    required this.providerData,
    required this.stsTokenManager,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      isAnonymous: json['isAnonymous'],
      providerData: (json['providerData'] as List)
          .map((item) => ProviderData.fromJson(item))
          .toList(),
      stsTokenManager: StsTokenManager.fromJson(json['stsTokenManager']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'emailVerified': emailVerified,
      'isAnonymous': isAnonymous,
      'providerData': providerData.map((item) => item.toJson()).toList(),
      'stsTokenManager': stsTokenManager.toJson(),
    };
  }
}

class ProviderData {
  final String providerId;
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  ProviderData({
    required this.providerId,
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
  });

  factory ProviderData.fromJson(Map<String, dynamic> json) {
    return ProviderData(
      providerId: json['providerId'],
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'providerId': providerId,
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
    };
  }
}

class StsTokenManager {
  final String refreshToken;
  final String accessToken;

  StsTokenManager({
    required this.refreshToken,
    required this.accessToken,
  });

  factory StsTokenManager.fromJson(Map<String, dynamic> json) {
    return StsTokenManager(
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'accessToken': accessToken,
    };
  }
}

