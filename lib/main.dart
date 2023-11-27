import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revest_app/app_configs/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_configs/app_page_routes.dart';
import 'pages/splash_page.dart';
import 'utils/shared_preference_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Revest App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      initialRoute: SplashPage.routeName,
      getPages: AppPages.pages,
    );
  }
}
