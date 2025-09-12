import 'package:appro_chat/core/resources/data_state.dart';
import 'package:appro_chat/feature/home/data/data_source/remote/home_api_provider.dart';
import 'package:appro_chat/feature/home/data/models/get_chat.dart';
import 'package:appro_chat/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryimpl extends HomeRepository {
  HomeApiProvider homeApiProvider;

  HomeRepositoryimpl({required this.homeApiProvider});
  @override
  Future<DataState<GetChat>> storeChat(String system, String user) async {
    final res = await homeApiProvider.storeChat(system, user);
    if (res.statusCode == 200) {
      return DataSuccess(GetChat.fromJson(res.data['choices'][0]['message']));
    } else {
      return DataError(res.statusMessage);
    }
  }
}
