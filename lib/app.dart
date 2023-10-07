import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'res/app_localizations_delegate.dart';
import 'routes/route_generator.dart';
import 'ui/stock_list_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    log("SELECT LANG -->> ${newLocale.countryCode} / ${newLocale.languageCode}");
    // ignore: unused_local_variable
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _locale = const Locale("en");
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Scan Parser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: StockListScreen.id,
      onGenerateRoute: RouteGenerator().generateRoute,
      locale: _locale,
      supportedLocales: const [
        Locale("en"),
        Locale("hi"),
        Locale("zh"),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocal in supportedLocales) {
          if (supportedLocal.languageCode == locale?.languageCode &&
              supportedLocal.countryCode == locale?.countryCode) {
            return supportedLocal;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
