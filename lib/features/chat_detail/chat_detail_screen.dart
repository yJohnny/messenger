import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/features/chat_detail/chat_detail_cubit.dart';
import 'package:messenger/features/chat_detail/chat_detail_state.dart';
import 'package:messenger/widgets/custom_text_field.dart';
import 'package:messenger/widgets/message_widget.dart';
import '../../di/di.dart';
import '../../services/auth_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final String userName;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.userName,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailCubit(chatId: widget.chatId),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.userName)),
        body: SafeArea(
          child: BlocConsumer<ChatDetailCubit, ChatDetailState>(
            listener: (context, chatDetailState) {
              if (chatDetailState.messages?.isNotEmpty == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  }
                });
              }
            },
            builder: (context, chatDetailState) {
              final chatDetailCubit = BlocProvider.of<ChatDetailCubit>(context);
              return Column(
                children: [
                  Expanded(
                    child:
                        chatDetailState.messages == null
                            ? Center(child: CircularProgressIndicator())
                            : SingleChildScrollView(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 20.h,
                              ),
                              child: Column(
                                children:
                                    chatDetailState.messages!.map((
                                      eachMessage,
                                    ) {
                                      return MessageWidget(
                                        isOtherUser:
                                            eachMessage.senderId !=
                                            getIt
                                                .get<AuthService>()
                                                .currentUser
                                                ?.uid,
                                        messageModel: eachMessage,
                                      );
                                    }).toList(),
                              ),
                            ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hint: 'Type something..',
                            textEditingController: messageController,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        IconButton(
                          onPressed: () async {
                            if (messageController.value.text
                                .trim()
                                .isNotEmpty) {
                              final result = await chatDetailCubit.sendMessage(
                                message: messageController.text,
                              );

                              if (result) {
                                messageController.clear();
                              }
                            }
                          },
                          icon: Icon(Icons.send, color: AppColors.darkGreen),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
