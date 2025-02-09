import 'package:flutter/material.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/custom_app_bar.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/signup_view_body.dart';
import 'widgets/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: buildAppbar(context, title: 'Sign Up'),
        body: const SignupViewBody(),
      ),
    );
  }
}
