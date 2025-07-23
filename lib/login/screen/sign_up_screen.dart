import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:register_app/auth/provider/auth_provider.dart';
import 'package:register_app/login/screen/sign_in_screen.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_container.dart';
import 'package:register_app/utils/custom_text.dart';
import 'package:register_app/utils/custom_textformfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void registerUser(BuildContext context, AuthProvider provider) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final result = await provider.signUp(
      userNameController.text.trim(),
      passwordController.text.trim(),
      emailController.text.trim(),
      phoneController.text.trim(),
    );

    Navigator.of(context).pop();

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrasi berhasil! Silakan login.")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Register failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        height: 380.h,
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
              controller: emailController,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter your email'
                          : null,
              obscureText: false,
              label: 'Email',
            ),
            10.verticalSpace,
            CustomTextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 13,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter your phone number'
                          : null,
              obscureText: false,
              label: 'Phone',
            ),
            10.verticalSpace,
            CustomTextFormField(
              controller: passwordController,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter your password'
                          : null,
              obscureText: true,
              label: 'Password',
            ),
            25.verticalSpace,

            Consumer<AuthProvider>(
              builder: (context, provider, _) {
                return GestureDetector(
                  onTap:
                      provider.isLoading
                          ? null
                          : () => registerUser(context, provider),
                  child: CustomContainer(
                    color: AppColors.textHeaderColor,
                    child: Center(
                      child: CustomText(
                        text: 'Sign Up',
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
                text: 'Already have an account?',
                fontSize: 18,
                color: AppColors.textHeaderColor,
              ),
            ),
            10.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: CustomText(
                  text: 'Sign In',
                  fontSize: 18,
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
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
                  'Create a username and password that is easy to remember, and of course you can change it later.',
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
