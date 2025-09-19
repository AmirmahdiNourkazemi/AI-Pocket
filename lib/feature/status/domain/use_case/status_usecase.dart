import 'package:appro_chat/core/resources/data_state.dart';
import 'package:appro_chat/core/usecase/use_case.dart';
import 'package:appro_chat/feature/status/data/model/status_model.dart';
import 'package:appro_chat/feature/status/domain/repository/status_repository.dart';

class StatusUsecase implements UseCase<DataState<StatusModel>, void> {
  final StatusRepository statusRepository;
  StatusUsecase(this.statusRepository);
  @override
  Future<DataState<StatusModel>> call(void params) {
    return statusRepository.getStatus();
  }
}
