import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_gallery/core/helper_functions/on_generate_route.dart';
import 'package:art_gallery/core/services/custom_bloc_observer.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/services/shared_preferences_singleton.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/features/splash/presentation/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAX0M76JgbDLTxFxcPJrm0ynLPmbb76qbc',
        appId: '1:161803360242:android:1f0d42fe6f08b2b03c7d6b',
        projectId: 'project-66490',
        messagingSenderId: ' '),
  );
  await Supabase.initialize(
    url: 'https://thyuemmcoaeuladmkayf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoeXVlbW1jb2FldWxhZG1rYXlmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMzAxMDczOSwiZXhwIjoyMDQ4NTg2NzM5fQ.1z8vwvUNF7muYhFaJtJnE4E9LwnLNpCVSSSMdHS1RVU',
  );
  await Prefs.init();
  setupGetit();

  runApp(const ArtGallery());
}

final supabase = Supabase.instance.client;

class ArtGallery extends StatelessWidget {
  const ArtGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
