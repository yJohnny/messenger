import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/chat_detail/chat_detail_state.dart';
import 'package:messenger/utils/extensions.dart';
import '../../di/di.dart';
import '../../services/auth_service.dart';
import '../../services/store_service.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final String chatId;
  ChatDetailCubit({required this.chatId}) : super(ChatDetailState()) {
    getIt.get<StoreService>().messagesStreamTyped(chatId).listen((messages) {
      safeEmit(ChatDetailState(messages: messages));
    });
  }

  Future<bool> sendMessage({required String message}) async {
    try {
      await getIt.get<StoreService>().sendMessage(
        chatId: chatId,
        senderId: getIt.get<AuthService>().currentUser?.uid ?? 'id',
        text: message,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
