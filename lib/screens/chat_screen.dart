// FILE PATH: lib/screens/chat_screen.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Chat screen coming soon...',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
