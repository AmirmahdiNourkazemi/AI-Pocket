
import 'status_status.dart';

class StatusState {
  final Status status;
  StatusState({required this.status});

  StatusState copyWith({Status? status }) {
  return  StatusState(status: status ?? this.status);
  
  
  }
      
}