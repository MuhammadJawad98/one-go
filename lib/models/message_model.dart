class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;
  final bool isOnline;

  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}