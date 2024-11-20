import 'package:flutter/material.dart';
import 'package:fruits_hub/constants.dart';
import 'package:fruits_hub/core/widgets/custom_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_field.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/have_an_account.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
                hintText: 'Full Name', textInputType: TextInputType.name),
            SizedBox(
              height: 16,
            ),
            CustomTextFormField(
                hintText: 'Email Address',
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              suffixIcon: Icon(
                Icons.remove_red_eye,
                color: Color(0xFFC9CECF),
              ),
              hintText: 'Password',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 33,
            ),
            TermsandConditionsWidget(),
            const SizedBox(
              height: 30,
            ),
            CustomButton(onPressed: () {}, text: 'Create new Account'),
            const SizedBox(height: 26),
            const HaveAnAccountWidget(),
          ],
        ),
      ),
    );
  }
}
