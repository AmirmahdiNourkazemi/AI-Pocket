import 'package:appro_chat/feature/auth/data/model/check_otp_model.dart';

import '../../data/model/appro_model.dart';

class ApproEntity {
  final String? approToken;
  final User? user;

 const ApproEntity({this.approToken, this.user});
}