import 'package:appro_chat/core/resources/data_state.dart';
import 'package:appro_chat/core/usecase/use_case.dart';
import 'package:appro_chat/feature/home/data/models/get_chat.dart';
import 'package:appro_chat/feature/home/domain/repository/home_repository.dart';

class StoreChatUsecase extends UseCase<DataState<GetChat> , StoreMessage> {
  HomeRepository homeRepository;
  StoreChatUsecase(this.homeRepository);
  @override
  Future<DataState<GetChat>> call(StoreMessage params) {
    return homeRepository.storeChat(params.system, params.user);
  }
}