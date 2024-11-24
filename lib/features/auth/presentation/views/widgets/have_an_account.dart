import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Already have an account? ",
            style: TextStyles.semiBold16.copyWith(
              color: const Color(0xFF616A6B),
            ),
          ),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pop(context);
                },
              text: 'Login',
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.primaryColor,
              )),
        ],
      ),
    );
  }
}
