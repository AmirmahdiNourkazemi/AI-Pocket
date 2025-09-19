import 'package:bloc/bloc.dart';


import '../../../../core/localstorage/local_data.dart';
import '../../../../core/locator/locator.dart';
import '../../../../core/resources/data_state.dart';
import '../../data/model/status_model.dart';
import '../../domain/use_case/status_usecase.dart';
import 'status_event.dart';
import 'status_state.dart';
import 'status_status.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final StatusUsecase statusUseCase;
  StatusBloc(this.statusUseCase) : super(StatusState(status: StatusInitial())) {
    on<StatusInitialEvent>(
      (event, emit) async {
        emit(state.copyWith(status: StatusLoading()));
        DataState dataState = await statusUseCase.call(null);
        if (dataState is DataSuccess) {
          StatusModel data = dataState.data as StatusModel;
          emit(state.copyWith(status: StatusSuccess(dataState.data)));
          if (data.products != null) {
            await locator<LocalData>().saveStatus(data);
          }
        }
        if (dataState is DataError) {
          emit(state.copyWith(status: StatusError(dataState.error!)));
        }
      },
    );
  }
}
