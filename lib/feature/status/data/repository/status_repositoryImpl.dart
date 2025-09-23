import 'package:dio/dio.dart';

import '../../../../core/error/custome_error.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/status_repository.dart';
import '../data_source/remote/status_api_provider.dart';
import '../model/product_model.dart';
import '../model/status_model.dart';

class StatusRepositoryimpl extends StatusRepository {
  final StatusApiProvider apiProvider;

  StatusRepositoryimpl(this.apiProvider);

  @override
  Future<DataState<StatusModel>> getStatus() async {
    Response response = await apiProvider.getStatus();
    if (response.statusCode == 200) {
      var data = StatusModel.fromJson(response.data);
      return DataSuccess(data);
    } else {
      return DataError(
          errorConvertor(response.statusCode, response.data['message']));
    }
  }

  // @override
  // Future<DataState<StatusModel>> getStatusV1() async {
  //   Response response = await apiProvider.getStatusV1();
  //   if (response.statusCode == 200) {
  //     var data = StatusModel.fromJson(response.data);
  //     data.products!.add(
  //       ProductModel(
  //         id: 0,
  //         package_name_id: 1,
  //         pivot: null,
  //         price: 0,
  //         title: null,
  //         uuid: null,
  //       )
  //     );
  //     return DataSuccess(data);
  //   } else if (response.statusCode == 400) {
  //     // Handle retry logic
  //     var responseGetStatus = await apiProvider.getStatus();
  //     if (responseGetStatus.statusCode == 200) {
  //       var additionalData = StatusModel.fromJson(responseGetStatus.data);
  //       var currentData = StatusModel.fromJson(response.data);

  //       // Append additional data to the existing model
  //       currentData.products?.addAll(additionalData.products ?? []);
  //       currentData.message ??= additionalData.message;

  //       return DataSuccess(currentData);
  //     } else {
  //       return DataError(errorConvertor(
  //           responseGetStatus.statusCode, responseGetStatus.data['message']));
  //     }
  //   } else {
  //     return DataError(
  //         errorConvertor(response.statusCode, response.data['message']));
  //   }
  // }
}
