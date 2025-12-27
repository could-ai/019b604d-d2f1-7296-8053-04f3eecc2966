import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../models/message.dart';

class ChatProvider with ChangeNotifier {
  final List<Chat> _chats = [
    Chat(
      id: '1',
      name: 'Alice Johnson',
      lastMessage: 'Hey, how are you doing?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      avatarUrl: 'https://via.placeholder.com/150',
      isOnline: true,
      unreadCount: 2,
    ),
    Chat(
      id: '2',
      name: 'Bob Smith',
      lastMessage: 'Thanks for the update!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      avatarUrl: 'https://via.placeholder.com/150',
      isOnline: false,
      unreadCount: 0,
    ),
    Chat(
      id: '3',
      name: 'Group Chat',
      lastMessage: 'Charlie: Meeting at 3 PM',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      avatarUrl: 'https://via.placeholder.com/150',
      isOnline: true,
      unreadCount: 1,
    ),
  ];

  List<Chat> get chats => _chats;

  final Map<String, List<Message>> _messages = {
    '1': [
      Message(
        id: '1',
        senderId: 'alice',
        content: 'Hey, how are you doing?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        type: MessageType.text,
        isRead: true,
        isMine: false,
      ),
      Message(
        id: '2',
        senderId: 'me',
        content: 'I\'m good, thanks! How about you?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        type: MessageType.text,
        isRead: false,
        isMine: true,
      ),
    ],
    '2': [
      Message(
        id: '3',
        senderId: 'bob',
        content: 'Thanks for the update!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: MessageType.text,
        isRead: true,
        isMine: false,
      ),
    ],
    '3': [
      Message(
        id: '4',
        senderId: 'charlie',
        content: 'Meeting at 3 PM',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: MessageType.text,
        isRead: true,
        isMine: false,
      ),
      Message(
        id: '5',
        senderId: 'me',
        content: 'Got it, see you there!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        type: MessageType.text,
        isRead: false,
        isMine: true,
      ),
    ],
  };

  List<Message> getMessagesForChat(String chatId) {
    return _messages[chatId] ?? [];
  }

  void addMessage(String chatId, Message message) {
    if (_messages[chatId] == null) {
      _messages[chatId] = [];
    }
    _messages[chatId]!.add(message);
    // Update last message in chat
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(
        lastMessage: message.content,
        lastMessageTime: message.timestamp,
        unreadCount: message.isMine ? _chats[chatIndex].unreadCount : _chats[chatIndex].unreadCount + 1,
      );
    }
    notifyListeners();
  }

  void markAsRead(String chatId) {
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(unreadCount: 0);
      final messages = _messages[chatId];
      if (messages != null) {
        for (var i = 0; i < messages.length; i++) {
          if (!messages[i].isMine) {
            messages[i] = messages[i].copyWith(isRead: true);
          }
        }
      }
      notifyListeners();
    }
  }
}