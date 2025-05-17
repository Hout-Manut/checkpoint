import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:checkpoint/entities/enums/theme.dart";
import "package:checkpoint/firebase_options.dart";
import "package:checkpoint/pages/home/home.dart";
import "package:checkpoint/repositories/r1_race/firebase.dart";
import "package:checkpoint/repositories/r2_checkpoint/firebase.dart";
import "package:checkpoint/services/checkpoint_provider.dart";
import "package:checkpoint/services/current_race_provider.dart";
import "package:checkpoint/services/races_provider.dart";
import "package:checkpoint/services/user_service.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  CurrentRaceProvider.initialize(FirebaseRaceRepo());
  CheckpointProvider.initialize(FirebaseCheckpointRepo());
  UserService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => RacesProvider(FirebaseRaceRepo()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CurrentRaceProvider(),
        ),
         ChangeNotifierProvider(
          create: (ctx) => CheckpointProvider(),
        ),
      ],
      builder:
          (ctx, child) => MaterialApp(
            // showPerformanceOverlay: true,
            debugShowCheckedModeBanner: false,
            theme: CheckpointTheme.appTheme,
            home: HomeScreen(),
          ),
    ),
  );
}
