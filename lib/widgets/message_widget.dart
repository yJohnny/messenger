import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger/models/message_model.dart';
import 'package:messenger/utils/string_helper.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class MessageWidget extends StatelessWidget {
  final bool isOtherUser;
  final MessageModel messageModel;
  const MessageWidget({
    super.key,
    this.isOtherUser = false,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isOtherUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: isOtherUser ? AppColors.darkGreen : AppColors.lightGreen,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.r),
          ).copyWith(
            bottomRight: isOtherUser ? Radius.circular(12.r) : Radius.zero,
            bottomLeft: isOtherUser ? Radius.zero : Radius.circular(12.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        margin: EdgeInsets.only(
          bottom: 10.h,
          right: isOtherUser ? 100.w : 0,
          left: isOtherUser ? 0 : 100.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              messageModel.text,
              style: AppTextStyles.s16.copyWith(
                fontWeight: FontWeight.w600,
                color: isOtherUser ? Colors.white : Colors.black,
              ),
            ),
            Text(
              StringHelper.formatDateTime(
                dateTime: messageModel.time,
                onlyHours: true,
              ),
              style: AppTextStyles.s14.copyWith(
                fontWeight: FontWeight.w400,
                color: isOtherUser ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
