import 'package:car_wash_app/views/messages/widget/message_cell.dart';
import 'package:flutter/material.dart';
import '../../models/message_model.dart';
import '../../utils/app_assets.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Message> messages = [
    Message(
      id: '1',
      senderName: 'John Doe',
      senderImage: 'https://randomuser.me/api/portraits/men/1.jpg',
      lastMessage: 'Hey, how are you doing?',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      isOnline: true,
    ),
    Message(
      id: '2',
      senderName: 'Sarah Smith',
      senderImage: 'https://randomuser.me/api/portraits/women/2.jpg',
      lastMessage: 'Meeting at 3pm tomorrow',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 0,
    ),
    Message(
      id: '3',
      senderName: 'Tech Support',
      senderImage: 'https://randomuser.me/api/portraits/men/3.jpg',
      lastMessage: 'Your issue has been resolved',
      time: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
    ),
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  CustomImageButton(onTap: () {}),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(text: 'Messages', fontSize: 16),
                    ),
                  ),
                  CustomImageButton(asset: AppAssets.search, onTap: () {}),
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: messages.isEmpty
                    ? const Center(child: Text('No messages yet'))
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return MessageCell(
                            message: message,
                            onTap: () {
                              // Navigate to chat screen
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(message: message));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
