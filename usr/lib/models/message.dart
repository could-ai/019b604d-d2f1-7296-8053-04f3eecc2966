import 'package:flutter/material.dart';

enum MessageType { text, image, voice }

class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final bool isRead;
  final bool isMine;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.isMine,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? content,
    DateTime? timestamp,
    MessageType? type,
    bool? isRead,
    bool? isMine,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      isMine: isMine ?? this.isMine,
    );
  }
}