import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/resources/data_state.dart';
import 'package:appro_chat/feature/home/domain/usecase/store_chat_usecase.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_event.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_state.dart';
import 'package:bloc/bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  StoreChatUsecase storeChatUsecase;
  ChatBloc(this.storeChatUsecase) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(ChatLoading());
      DataState dataState;
      var freeChat = LocalData.storeMessageCount.value;
      var status = LocalData.statusNotifier.value;
    
        dataState = await storeChatUsecase(event.message);
        if (dataState is DataSuccess) {
          if (status!.products?.isEmpty ?? true) {
            // if (freeChat! > 0) {
            //   await locator<LocalData>()
            //       .saveStoreMessageCount(freeChat > 0 ? freeChat - 1 : 1);
            // }
            emit(ChatSuccess(dataState.data));
          } else {
            emit(ChatSuccess(dataState.data));
          }
        }
        if (dataState is DataError) {
          emit(ChatFailure(dataState.error!));
          // await locator<LocalData>().saveFreeUsageCount(freeUsage!);
        }
      
    });
    on<ClearChatEvent>((event, emit) {
      emit(ChatInitial());
    });
  }
}
