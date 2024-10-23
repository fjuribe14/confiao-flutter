import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  /** Ensure that plugin services are initialized */
  WidgetsFlutterBinding.ensureInitialized();

  /** Initialize Firebase */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /** Set preferred orientations */
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /** Load .env file */
  await dotenv.load(fileName: kDebugMode ? '.env' : '.env.prod');

  /** Get env variables */
  final appName = dotenv.env['APP_NAME'] ?? 'Confiao';

  runApp(MyApp(appName: appName));
}

class MyApp extends StatelessWidget {
  final String appName;

  const MyApp({super.key, required this.appName});

  @override
  Widget build(BuildContext context) {
    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Work Sans");

    MaterialTheme theme = MaterialTheme(textTheme);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: appName,
        darkTheme: theme.dark(),
        getPages: AppRoutes.pages,
        locale: Localization.locale,
        translations: Localization(),
        initialRoute: AppRouteName.onboarding,
        debugShowCheckedModeBanner: kDebugMode,
        fallbackLocale: Localization.fallbackLocale,
        theme: Get.isDarkMode ? theme.dark() : theme.light(),
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (BuildContext context) => const NotFoundPage(),
        ),
      ),
    );
  }
}
