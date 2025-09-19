import 'package:bloc/bloc.dart';

import '../localstorage/local_data.dart';
import '../locator/locator.dart';
import 'session_event.dart';
import 'session_state.dart';

class CheckAuthBloc extends Bloc<CheckAuthEvent, CheckAuthState> {
  CheckAuthBloc() : super(CheckAuthLoading()) {
    on<CheckAuthEvent>((event, emit) async {
      if (event is CheckAuthStart) {
        await locator<LocalData>().loadApproToken();
        final auth = LocalData.firstTokenNotifier.value;
        print(auth);
        if (auth == '' ) {
          emit(CheckAuthRequired());
        } else {
            await locator<LocalData>().loadStatus;
            emit(CheckAuthNotRequired());
        }
      } else if (event is CheckAuthChangeInfo) {
        final authInfo = LocalData.firstTokenNotifier.value;

        if (authInfo == null || authInfo.isEmpty) {
          emit(CheckAuthRequired());
        } else {
          emit(CheckAuthNotRequired());
        }
      }
    });
  }
}