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
      DataState result = await storeChatUsecase(event.message);
      // result.fold((l) => emit(ChatFailure(l.message)), (r) => emit(ChatSuccess(r)));
      if (result is DataSuccess) {
        emit(ChatSuccess(result.data));
      } else if (result is DataError) {
        emit(ChatFailure(result.error!));
      }
    });
    on<ClearChatEvent>((event, emit) {
      emit(ChatInitial());
    });
  }
}
