import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile.dart';
import 'package:study_stats/auth_screen/signup_screen/signup.dart';
import 'package:study_stats/auth_screen/signin_screen/sign_in.dart';
import 'package:study_stats/camera_delegate.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/simulate.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/on_boarding_screen.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/providers/mainProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/notification.dart';
import 'package:study_stats/settings/notification_servics.dart';
import 'package:study_stats/settings/qoute_notification.dart';
import 'package:study_stats/splash_screen.dart/splash_screen.dart';
import 'package:study_stats/theme/dark.theme.dart';
import 'package:study_stats/theme/light.theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'firebase_options.dart';

// import 'fi';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('userBox');
  Hive.registerAdapter(QuickAdapter());
  await Hive.openBox('quick_box');
  await Hive.openBox('goal_box');
  Hive.registerAdapter(SimulateAdapter());
  await Hive.openBox('simulate_box');
  Hive.registerAdapter(UpdateAdapter());
  await Hive.openBox('update_box');
  bool accepted = await NotificationFunction.requestPermissions();
  if (accepted) {
    NotificationFunction.init();
  }
  // _configureLocalTimeZone();

  // static var studyStatBox = Hive.box('simulate_box');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // setUpCameraDelegate();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Future<void> _configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName));
// }

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      theme: lightTheme,
      // darkTheme: darkTheme,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        FillProfileScreen.id: (context) => FillProfileScreen(),
        MainScreen.id: (context) => MainScreen(),
        OnBoardingScreen.id: (context) => OnBoardingScreen()
      },
    );
  }
}
