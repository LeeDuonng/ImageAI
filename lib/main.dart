import 'dart:ui';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:ImageAI/screen/strings.dart';
import 'package:ImageAI/screen/app_theme.dart';

import 'screen/home_page.dart';
import 'screen/settings_page.dart';
import 'handlers/app_directory_cubit.dart';
import 'handlers/app_mode_cubit.dart';
import 'handlers/app_theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Future.delayed(const Duration(milliseconds: 1200)).then(
          (value) => FlutterNativeSplash.remove(),
    );
  }
  await SentryFlutter.init(
    (options) => options.dsn =
        'https://725035c013bd4e7495b4fc7e472f6c5f@o4505074740953088.ingest.sentry.io/4505074742132736',
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppThemeCubit(material)..loadTheme(),
        ),
        BlocProvider(
          create: (_) => AppModeCubit(system)..loadMode(),
        ),
        BlocProvider(
          create: (_) => AppDirectoryCubit(pathHint)..loadPath(),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, appTheme) {
          return BlocBuilder<AppModeCubit, AppModeState>(
            builder: (context, appMode) {
              return Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.select):
                      const ActivateIntent(),
                },
                child: MaterialApp(
                  scrollBehavior: CustomScroll(),
                  initialRoute: '/',
                  routes: {
                    '/': (_) => const HomePage(),
                    '/Settings': (_) => const SettingsPage(),
                  },
                  debugShowCheckedModeBanner: false,
                  themeMode: getMode(appMode.mode),
                  theme: appTheme.theme.lightTheme,
                  darkTheme: appTheme.theme.darkTheme,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CustomScroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
