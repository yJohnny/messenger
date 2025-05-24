import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/chats/chats_screen.dart';
import 'package:messenger/features/login/login_screen.dart';
import 'package:messenger/features/registration/registration_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(
      path: '/registration',
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(path: '/chats', builder: (context, state) => ChatsScreen()),
  ],
  redirect: (context, state) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isGoingToLogin = state.fullPath == '/';
    final isGoingToRegistration = state.fullPath == '/registration';

    if (currentUser == null) {
      return isGoingToLogin || isGoingToRegistration ? null : '/';
    } else {
      return isGoingToLogin || isGoingToRegistration ? '/chats' : null;
    }
  },
);
