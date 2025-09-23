
abstract class CheckAuthState {}

class CheckAuthLoading extends CheckAuthState {}

class CheckAuthRequired extends CheckAuthState {}

class CheckAuthNotRequired extends CheckAuthState {}

class CheckAuthCompleteProfile extends CheckAuthState {}