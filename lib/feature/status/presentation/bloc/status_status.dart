import '../../data/model/status_model.dart';

abstract class Status{}

class StatusInitial extends Status {}

class StatusLoading extends Status {}
 
 class StatusSuccess extends Status {
  final StatusModel status;
  StatusSuccess(this.status);
 }

 class StatusError extends Status {
  final String message;
  StatusError(this.message);
 }