import '../../domain/entities/check_otp_entity.dart';

class CheckOtpModel extends CheckOtpEntity {
  CheckOtpModel({
    super.token,
    super.user,
  });

  factory CheckOtpModel.fromJson(Map<String, dynamic> json) => CheckOtpModel(
        token: json['token'],
        user: User.fromJson(json['user']), // Handle null case
      );
}

class User {
  int? id;
  String? mobile;

  User({
    this.id,
    this.mobile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        mobile: json['mobile'],
      );
}
