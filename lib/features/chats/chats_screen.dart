import 'package:flutter/material.dart';

import '../../di/di.dart';
import '../../services/auth_service.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Column(
        children: [
          Text('This is chats screen'),
          ElevatedButton(
            onPressed: () async {
              await getIt.get<AuthService>().signOut();
            },
            child: Text('Log out'),
          ),
        ],
      ))),
    );
  }
}
