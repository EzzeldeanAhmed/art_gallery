import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/core/widgets/password_field.dart';
import 'package:art_gallery/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/dont_have_account_widget.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/social_login_button.dart';
import 'package:art_gallery/main.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Your Password?',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<SigninCubit>().signin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'Login'),
              const SizedBox(height: 33),
              const DontHaveAnAccountWidget(),
              const SizedBox(height: 33),
              const OrDivider(),
              const SizedBox(height: 16),
              SocialLoginButton(
                OnPressed: () {},
                image: Assets.imagesGoogleIcon,
                title: 'Sign in with Google',
              ),
              const SizedBox(height: 16),
              SocialLoginButton(
                OnPressed: () {},
                image: Assets.imagesApplIcon,
                title: 'Sign in with Apple',
              ),
              const SizedBox(height: 16),
              SocialLoginButton(
                OnPressed: () {},
                image: Assets.imagesFacebookIcon,
                title: 'Sign in with Facebook',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
