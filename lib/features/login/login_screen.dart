import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_text_styles.dart';
import 'package:messenger/constants/screen_paths.dart';
import 'package:messenger/features/login/login_state.dart';
import 'package:messenger/utils/validators.dart';
import 'package:messenger/widgets/custom_button.dart';
import 'package:messenger/widgets/custom_text_field.dart';
import '../../constants/app_assets.dart';
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
              ).copyWith(top: 150.h, bottom: 50.h),
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
                        autovalidateMode:
                            state.autoValidate
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        child: Column(
                          children: [
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
                                  title: 'Login',
                                  onPressed: () async {
                                    if (formKey.currentState?.validate() ==
                                        true) {
                                      await loginCubit.login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    } else {
                                      loginCubit.switchToAutoValidate();
                                    }
                                  },
                                ),
                          ],
                        ),
                      ),

                      Column(
                        spacing: 10.h,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Text(
                                  'Or continue with',
                                  style: AppTextStyles.s20.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await loginCubit.signInWithGoogle();
                            },
                            child: Container(
                              width: 70.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(15.w),
                              child: Image.asset(
                                AppAssets.googleLogo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
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
                              context.push(ScreenPaths.registration);
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
