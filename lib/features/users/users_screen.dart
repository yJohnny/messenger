import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/constants/app_text_styles.dart';
import 'package:messenger/constants/screen_paths.dart';
import 'package:messenger/features/users/users_cubit.dart';
import 'package:messenger/features/users/users_state.dart';
import 'package:messenger/services/auth_service.dart';
import '../../di/di.dart';
import '../../services/store_service.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All users')),
      body: SafeArea(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, usersState) {
            if (usersState.allUsers == null) {
              return Center(child: CircularProgressIndicator());
            } else if (usersState.allUsers?.isNotEmpty == true) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemCount: usersState.allUsers!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      final chatId = await getIt
                          .get<StoreService>()
                          .getOrCreatePrivateChat(
                            getIt.get<AuthService>().currentUser?.uid ??
                                'currentId',
                            usersState.allUsers![index].uid ?? 'userId',
                          );
                      if (context.mounted) {
                        context.pushReplacement(
                          '${ScreenPaths.chatDetail}/$chatId/${usersState.allUsers![index].name}',
                        );
                      }
                    },
                    leading: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(
                      usersState.allUsers![index].name ?? 'name',
                      style: AppTextStyles.s20,
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No users found', style: AppTextStyles.s20),
              );
            }
          },
        ),
      ),
    );
  }
}
