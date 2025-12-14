import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../contracts/contracts.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Contracts _chatServices;
  StreamSubscription? _subscription;

  ChatBloc(this._chatServices) : super(const ChatState(isLoading: true)) {
    _initializeSubscription();

    on<MessagesUpdated>(_onMessagesUpdated);
    on<MessagesError>(_onMessagesError);
    on<SendMessage>(_onSendMessage);
  }

  void _initializeSubscription() {
    _subscription?.cancel();

    _subscription = _chatServices.getMessages().listen(
      (messages) {
        add(MessagesUpdated(messages));
      },
      onError: (error) {
        add(MessagesError(error.toString()));
      },
    );
  }

  Future<void> _onMessagesUpdated(
    MessagesUpdated event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(messages: event.messages, isLoading: false, error: null),
    );
  }

  Future<void> _onMessagesError(
    MessagesError event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(error: event.error, isLoading: false));
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatServices.sendMessage(event.text);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
