import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:register_app/auth/forgot_password_screen.dart';
import 'package:register_app/auth/provider/auth_provider.dart';
import 'package:register_app/home/screen/home_screen.dart';
import 'package:register_app/login/screen/sign_up_screen.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_container.dart';
import 'package:register_app/utils/custom_text.dart';
import 'package:register_app/utils/custom_textformfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser(BuildContext context, AuthProvider provider) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await provider.login(
      userNameController.text.trim(),
      passwordController.text.trim(),
    );

    Navigator.of(context).pop();

    if (result['success']) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login successful!")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.glass,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                validator: null,
                obscureText: false,
                label: 'Username',
              ),
              10.verticalSpace,
              CustomTextFormField(
                controller: passwordController,
                validator: null,
                obscureText: true,
                label: 'Password',
              ),
              15.verticalSpace,
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: CustomText(
                    text: 'Forgot Password?',
                    fontSize: 15,
                    color: AppColors.textHeaderColor,
                  ),
                ),
              ),
              15.verticalSpace,

              Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return GestureDetector(
                    onTap:
                        provider.isLoading
                            ? null
                            : () => loginUser(context, provider),
                    child: CustomContainer(
                      color: AppColors.textHeaderColor,
                      child: Center(
                        child: CustomText(
                          text: 'Sign In',
                          fontSize: 20,
                          color: AppColors.glass,
                        ),
                      ),
                    ),
                  );
                },
              ),

              10.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'Don\'t have an account?',
                  fontSize: 18,
                  color: AppColors.textHeaderColor,
                ),
              ),
              5.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  child: CustomText(
                    text: 'Sign Up',
                    fontSize: 18,
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/x.png', scale: 3),
            ),
            20.verticalSpace,
            CustomText(
              text: 'Welcome to Voucher App',
              fontSize: 20,
              color: AppColors.glass,
            ),
            20.verticalSpace,
            CustomText(
              text:
                  'Please login with the account you have created in the previous step.',
              fontSize: 20,
              color: AppColors.glass,
            ),
            25.verticalSpace,
            CustomText(
              text: 'Enjoy using the app',
              fontSize: 20,
              color: AppColors.glass,
            ),
          ],
        ),
      ),
    );
  }
}
