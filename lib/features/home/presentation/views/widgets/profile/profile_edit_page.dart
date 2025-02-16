import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        // leading: const AppBackButton(),
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16 * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* <----  First Name -----> */
              const Text("First Name"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              /* <---- Last Name -----> */
              const Text("Last Name"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              /* <---- Phone Number -----> */
              const Text("Phone Number"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              /* <---- Gender -----> */
              const Text("Gender"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              /* <---- Birthday -----> */
              const Text("Birthday"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              /* <---- Password -----> */

              /* <---- Birthday -----> */
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              /* <---- Submit -----> */
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
