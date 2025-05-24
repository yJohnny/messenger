import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_text_styles.dart';
import 'package:messenger/features/login/login_state.dart';
import 'package:messenger/widgets/custom_button.dart';
import 'package:messenger/widgets/custom_text_field.dart';
import 'login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
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
              ).copyWith(top: 300.h, bottom: 50.h),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.errMsg != null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMsg!)));
                  }
                },
                builder: (context, state) {
                  final loginCubit = BlocProvider.of<LoginCubit>(context);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 10.h,
                        children: [
                          Text(
                            'Welcome Back',
                            style: AppTextStyles.s40.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                            ),
                          ),
                          Text(
                            'Login to your account',
                            style: AppTextStyles.s20.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          spacing: 10.h,
                          children: [
                            CustomTextField(
                              textEditingController: emailController,
                              hint: 'Enter email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            CustomTextField(
                              textEditingController: passwordController,
                              hint: 'Enter password',
                              hideText: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        spacing: 10.h,
                        children: [
                          state.isLoading
                              ? LinearProgressIndicator()
                              : CustomButton(
                                title: 'Login',
                                onPressed: () async {
                                  await loginCubit.login(
                                    email: emailController.value.text,
                                    password: passwordController.value.text,
                                  );
                                },
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: AppTextStyles.s16.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push('/registration');
                                },
                                child: Text(
                                  'Sign Up',
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
