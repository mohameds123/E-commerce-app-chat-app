abstract class ChatState{}

class ChatInitialState extends ChatState{}

class ChatStateLoading extends ChatState{}

class ChatStateSuccess extends ChatState{}

class ChatStateError extends ChatState{}

class SentMessageStateLoading extends ChatState{}

class SentMessageStateSuccess extends ChatState{}

class SentMessageStateError extends ChatState{}