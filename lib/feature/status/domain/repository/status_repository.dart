import '../../../../core/resources/data_state.dart';
import '../../data/model/status_model.dart';

abstract class StatusRepository {
  Future<DataState<StatusModel>> getStatus();
  // Future<DataState<StatusModel>> getStatusV1();
}
