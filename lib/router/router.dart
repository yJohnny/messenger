import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/constants/screen_paths.dart';
import 'package:messenger/features/chat_detail/chat_detail_screen.dart';
import 'package:messenger/features/chats/chats_screen.dart';
import 'package:messenger/features/login/login_screen.dart';
import 'package:messenger/features/registration/registration_screen.dart';
import 'package:messenger/features/users/users_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(
      path: ScreenPaths.registration,
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(
      path: ScreenPaths.chats,
      builder: (context, state) => ChatsScreen(),
    ),
    GoRoute(
      path: '${ScreenPaths.chatDetail}/:chatId/:userName',
      builder: (context, state) {
        final chatId = state.pathParameters['chatId'];
        final userName = state.pathParameters['userName'];

        return ChatDetailScreen(chatId: chatId ?? '', userName: userName ?? '');
      },
    ),
    GoRoute(
      path: ScreenPaths.users,
      builder: (context, state) => UsersScreen(),
    ),
  ],
  redirect: (context, state) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isGoingToLogin = state.fullPath == '/';
    final isGoingToRegistration = state.fullPath == ScreenPaths.registration;

    if (currentUser == null) {
      return isGoingToLogin || isGoingToRegistration ? null : '/';
    } else {
      return isGoingToLogin || isGoingToRegistration ? ScreenPaths.chats : null;
    }
  },
);
