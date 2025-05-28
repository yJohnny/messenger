import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/constants/app_text_styles.dart';
import 'package:messenger/constants/screen_paths.dart';
import 'package:messenger/features/chats/chats_cubit.dart';
import 'package:messenger/features/chats/chats_state.dart';
import 'package:messenger/features/users/users_state.dart';
import 'package:messenger/utils/string_helper.dart';
import '../../di/di.dart';
import '../../services/auth_service.dart';
import '../users/users_cubit.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.push(ScreenPaths.users);
          },
          icon: Icon(Icons.add),
        ),
        title: Text('Chats'),
        actions: [
          IconButton(
            onPressed: () async {
              await getIt.get<AuthService>().signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, chatsState) {
            if (chatsState.chats == null) {
              return Center(child: CircularProgressIndicator());
            } else if (chatsState.chats?.isNotEmpty == true) {
              return BlocBuilder<UsersCubit, UsersState>(
                builder: (context, usersState) {
                  final usersCubit = BlocProvider.of<UsersCubit>(context);

                  if (usersState.allUsers?.isNotEmpty == true) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      itemCount: chatsState.chats!.length,
                      itemBuilder: (context, index) {
                        final otherUserId = chatsState.chats![index].members
                          .where(
                            (userId) =>
                                userId !=
                                getIt.get<AuthService>().currentUser?.uid,
                          )..cast<String>().toList();

                        final otherUser =
                            otherUserId.isNotEmpty
                                ? usersCubit.getUserById(otherUserId.first)
                                : null;

                        return GestureDetector(
                          onTap: () {
                            context.push(
                              '${ScreenPaths.chatDetail}/${chatsState.chats![index].chatId}/${otherUser?.name ?? 'Unknown'}',
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        otherUser?.name ?? 'otherUser',
                                        style: AppTextStyles.s20,
                                      ),
                                      Text(
                                        chatsState.chats![index].lastMessage,
                                        style: AppTextStyles.s16.copyWith(
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  StringHelper.formatDateTime(
                                    dateTime:
                                        chatsState
                                            .chats![index]
                                            .lastMessageTime ??
                                        DateTime.now(),
                                  ),
                                  style: AppTextStyles.s14.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return Center(
                child: Text('No chats available', style: AppTextStyles.s20),
              );
            }
          },
        ),
      ),
    );
  }
}
