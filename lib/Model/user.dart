import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String status;
  final String message;
  final Data data;

  const User({
    required this.status,
    required this.message,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };

  @override
  List<Object?> get props => [status, message, data];
}

class Data extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String avatar;
  final int earnings;
  final String role;
  final String status;
  final String isVerified;
  final DateTime joinedAt;
  final String ratings;
  final String bio;

  const Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.avatar,
    required this.earnings,
    required this.role,
    required this.status,
    required this.isVerified,
    required this.joinedAt,
    required this.ratings,
    required this.bio,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    gender: json["gender"],
    phone: json["phone"],
    avatar: json["avatar"],
    earnings: json["earnings"],
    role: json["role"],
    status: json["status"],
    isVerified: json["is_verified"],
    joinedAt: DateTime.parse(json["joined_at"]),
    ratings: json["ratings"],
    bio: json["bio"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "gender": gender,
    "phone": phone,
    "avatar": avatar,
    "earnings": earnings,
    "role": role,
    "status": status,
    "is_verified": isVerified,
    "joined_at": joinedAt.toIso8601String(),
    "ratings": ratings,
    "bio": bio,
  };

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    phone,
    avatar,
    earnings,
    role,
    status,
    isVerified,
    joinedAt,
    ratings,
    bio,
  ];
}
