import 'package:app_to_do/authentication/login/login_screen.dart';
import 'package:app_to_do/authentication/register/register_screen.dart';
import 'package:app_to_do/home/home_screen.dart';
import 'package:app_to_do/home/task_list/editing_task.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:app_to_do/providers/auth_providers.dart';
import 'package:app_to_do/providers/list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.enableNetwork();
  // FirebaseFirestore.instance.clearPersistence();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => ProviderConfig()
          ..getLanguageSP()
          ..getThemeSp()),
    ChangeNotifierProvider(create: (context) => ListProvider()),
    ChangeNotifierProvider(create: (context) => AuthProviders()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderConfig provider = Provider.of<ProviderConfig>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        EditingText.routeName: (context) => EditingText()
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.themeApp,
      locale: Locale(provider.languageApp),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
