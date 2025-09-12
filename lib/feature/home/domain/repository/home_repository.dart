import 'package:appro_chat/core/resources/data_state.dart';
import 'package:appro_chat/feature/home/data/models/get_chat.dart';

abstract class HomeRepository {
  Future<DataState<GetChat>> storeChat(String system, String user);
}