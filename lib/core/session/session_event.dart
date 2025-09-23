abstract class CheckAuthEvent {}

class CheckAuthStart extends CheckAuthEvent {

  CheckAuthStart();
}

class CheckAuthChangeInfo extends CheckAuthEvent {
  final String? fisrtToken;
  CheckAuthChangeInfo({required this.fisrtToken});
}