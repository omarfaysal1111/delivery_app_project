import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatInitial());

  String? _ticketId;

  Future<void> fetchMessages(String ticketId) async {
    _ticketId = ticketId;
    emit(const ChatLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(
      ChatLoaded([
        SupportChatMessage(
          id: '1',
          text: 'Hello, how can I help you today?',
          isMine: false,
          createdAt: DateTime.now(), // Fixed null to valid DateTime
        ),
      ]),
    );
  }

  Future<void> sendMessage(String text) async {
    if (_ticketId == null || text.isEmpty) return;

    final currentState = state;
    List<SupportChatMessage> currentMessages = [];
    if (currentState is ChatLoaded) {
      currentMessages = List.from(currentState.messages);
    }

    // Optimistic UI
    final newMessage = SupportChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isMine: true,
      createdAt: DateTime.now(),
    );

    emit(ChatLoaded([...currentMessages, newMessage]));
  }
}
