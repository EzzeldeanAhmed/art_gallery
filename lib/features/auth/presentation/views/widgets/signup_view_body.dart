import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/helper_functions/build_error_bar.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/core/widgets/password_field.dart';
import 'package:art_gallery/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:art_gallery/features/auth/presentation/views/signup_view.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/have_an_account.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, userName, password, birthDate;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final birthDateController = TextEditingController();

  late bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: nameController,
                onSaved: (value) {
                  userName = value!;
                },
                hintText: 'Full Name',
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                controller: phoneController,
                prefixWidget: CountryCodePicker(
                  onChanged: print,
                  initialSelection: 'EG',
                  favorite: ['+20', 'EG'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                onSaved: (value) {
                  email = value!;
                },
                length: 10,
                hintText: 'Phone number',
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Enter valid Phone number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                controller: birthDateController,
                readOnly: true,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year - 9),
                  );
                  if (dt != null) {
                    birthDateController.text =
                        dt.toIso8601String().split('T')[0];
                  }
                },
                hintText: 'Birth Date',
                textInputType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid Birth Date';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                controller: emailController,
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'Email Address',
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter email address';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail+\.com")
                      .hasMatch(value)) {
                    return 'Enter valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 33,
              ),
              TermsandConditionsWidget(
                onChanged: (value) {
                  isTermsAccepted = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                if (state is SignupSuccess) {
                  buildErrorBar(context, 'You are registered successfully');
                }
                if (state is SignupFailure) {
                  buildErrorBar(context, state.message);
                }
              }, builder: (context, state) {
                if (state is SignupLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (isTermsAccepted) {
                          context
                              .read<SignupCubit>()
                              .createUserWithEmailAndPassword(
                                  emailController.text,
                                  password,
                                  nameController.text,
                                  phoneController.text,
                                  birthDateController.text);
                        } else {
                          buildErrorBar(context,
                              'You must accept the Terms and Conditions');
                        }
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: 'Create new Account');
              }),
              const SizedBox(height: 26),
              const HaveAnAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
