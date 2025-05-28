import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_text_styles.dart';
import 'package:messenger/features/registration/registration_cubit.dart';
import 'package:messenger/features/registration/registration_state.dart';
import 'package:messenger/utils/validators.dart';
import 'package:messenger/widgets/custom_button.dart';
import 'package:messenger/widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    formKey.currentState?.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ).copyWith(top: 20.h, bottom: 50.h),
              child: BlocConsumer<RegistrationCubit, RegistrationState>(
                listener: (context, state) {
                  if (state.errMsg != null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMsg!)));
                  }
                },
                builder: (context, state) {
                  final registrationCubit = BlocProvider.of<RegistrationCubit>(
                    context,
                  );

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(10.w),
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),

                      Form(
                        key: formKey,
                        autovalidateMode:
                            state.autoValidate
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        child: Column(
                          children: [
                            Text(
                              'Register',
                              style: AppTextStyles.s40.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Create your new account',
                              style: AppTextStyles.s20.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            CustomTextField(
                              textEditingController: nameController,
                              validator: Validators.validateName,
                              hint: 'Enter name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CustomTextField(
                              textEditingController: emailController,
                              validator: Validators.validateEmail,
                              hint: 'Enter email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CustomTextField(
                              textEditingController: passwordController,
                              validator: Validators.validatePassword,
                              hint: 'Enter password',
                              hideText: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            state.isLoading
                                ? LinearProgressIndicator()
                                : CustomButton(
                                  title: 'Register',
                                  onPressed: () async {
                                    if (formKey.currentState?.validate() ==
                                        true) {
                                      await registrationCubit.register(
                                        name: nameController.value.text,
                                        email: emailController.value.text,
                                        password: passwordController.value.text,
                                      );
                                    } else {
                                      registrationCubit.switchToAutoValidate();
                                    }
                                  },
                                ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: AppTextStyles.s16.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                              'Sign In',
                              style: AppTextStyles.s16.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkGreen,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
