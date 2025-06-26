import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/service_locator.dart';

import 'core/application.dart';
import 'feature/presentation/viewmodels/splash_screen_viewmodel.dart';
import 'firebase_options.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await InjectionContainer.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState()..initializeApp(),
      child: Application(),
    ),
  );
}
