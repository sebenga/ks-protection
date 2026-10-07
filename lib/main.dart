import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'design.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: C.ink,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const KsProfileApp());
}

/// KS Protection Servicez — Company Profile 2026 (mobile edition).
///
/// A phone-native reading experience built from the 8-page A4 print deck:
/// the cover becomes a landing screen and the remaining pages become the
/// four scrollable chapters of the app.
class KsProfileApp extends StatelessWidget {
  const KsProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KS Protection Servicez',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.ink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: C.brass,
          brightness: Brightness.dark,
        ).copyWith(surface: C.ink, primary: C.brass),
        fontFamily: F.body,
        splashFactory: InkRipple.splashFactory,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}
