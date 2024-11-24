import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/features/auth/presentation/views/signup_view.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account? ",
            style: TextStyles.semiBold16.copyWith(
              color: const Color(0xFF616A6B),
            ),
          ),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, SignupView.routeName);
                },
              text: 'Create a new account',
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.primaryColor,
              )),
        ],
      ),
    );
  }
}
