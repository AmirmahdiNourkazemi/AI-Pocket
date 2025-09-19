import 'package:appro_chat/core/usecase/use_case.dart';
import 'package:appro_chat/feature/auth/domain/use_cases/google_use_case.dart';

import '../../../../core/localstorage/local_data.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../main.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:bloc/bloc.dart';

import 'login_status.dart';
import 'otp_status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  // final OtpUsecase otpUsecase;
  final AuthRepository authRepository;
  // final SaveUserUsecase saveUserUsecase;
  final GoogleUseCase googleUseCase;
  // final LoginAsGustUseCase loginAsGustUseCase;
  AuthBloc(this.loginUsecase, this.googleUseCase, this.authRepository)
      : super(
          AuthState(authStatus: LoginInitial(), otpStatus: OtpInitial()),
        ) {
    on<LoginOtpEvent>((event, emit) async {
      try {
        emit(state.copyWith(authStatus: LoginLoading()));
        DataState dataState = await googleUseCase(NoParams());
        if (dataState is DataSuccess) {
          emit(state.copyWith(authStatus: LoginSuccess(dataState.data)));
        }
        if (dataState is DataError) {
          emit(state.copyWith(authStatus: LoginError(dataState.error!)));
        }
      } catch (e) {
        emit(state.copyWith(authStatus: LoginError(e.toString())));
      }
    });

    // on<LoginAsGuestEvent>((event, emit) async {
    //     emit(state.copyWith(authStatus: LoginAsGustLoading()));
    //     DataState? dataState = await loginAsGustUseCase(NoParams());
    //     if (dataState is DataSuccess) {
    //       emit(state.copyWith(authStatus: LoginSuccess(dataState.data)));
    //     }
    //     if (dataState is DataError) {
    //       emit(state.copyWith(authStatus: LoginError(dataState.error!)));
    //     }
    //   });

    // on<CheckOtpEvent>((event, emit) async {
    //   emit(state.copyWith(otpStatus: OtpLoading()));
    //   DataState dataState = await otpUsecase(event.params);
    //   if (dataState is DataSuccess) {
    //     emit(state.copyWith(otpStatus: OtpSuccess(dataState.data)));
    //     var token = LocalData.firstTokenNotifier.value;
    //     var freeUsage = LocalData.freeUsageCount.value ?? 1;
    //       await locator<LocalData>().saveFreeUsageCount(freeUsage);
    //     var storeMessageCount = LocalData.storeMessageCount.value ?? 1;
    //     await locator<LocalData>().saveStoreMessageCount(storeMessageCount);
    //     var show = LocalData.showAppReview.value ?? 2;
    //     await locator<LocalData>().saveShowAppReview(show);
    //   }
    //   if (dataState is DataError) {
    //     emit(state.copyWith(otpStatus: OtpError(dataState.error!)));
    //   }
    // });

    //  on<SaveUserEvent>((event, emit) async{

    //   emit(state.copyWith(localStatus: LocalLoading()));
    //   DataState dataState = await saveUserUsecase(event.user);
    //   if (dataState is DataSuccess) {
    //     emit(state.copyWith(localStatus: LocalSuccess(dataState.data)));
    //   }
    //   if (dataState is DataError) {
    //     emit(state.copyWith(localStatus: LocalError(dataState.error!)));
    //   }
    // },);
  }
}
