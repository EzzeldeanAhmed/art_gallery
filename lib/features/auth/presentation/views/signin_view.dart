import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/custom_app_bar.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/signin_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: buildAppbar(context, title: 'Login'),
        body: const SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
