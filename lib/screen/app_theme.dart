import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import '../screen/strings.dart';

ThemeMode getMode(String appMode) {
  switch (appMode) {
    case light:
      return ThemeMode.light;
    case dark:
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

class AppTheme {
  final String name;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const AppTheme({
    required this.lightTheme,
    required this.name,
    required this.darkTheme,
  });
}


AppTheme indigoTheme = AppTheme(
  name: 'Mặc định',
  lightTheme: FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Arial',

  ),
  darkTheme: FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Arial',
  ),
);




AppTheme blueWhaleTheme = AppTheme(
  name: 'Xanh chàm',
  lightTheme: FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.blueWhale,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Arial',

  ),
  darkTheme: FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.blueWhale,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Arial',

  ),
);

AppTheme material = AppTheme(
  name: 'Tím mộng mơ',
  lightTheme: FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.material,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Arial',

  ),
  darkTheme: FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.material,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Arial',

  ),
);

AppTheme goldSunset = AppTheme(
  name: 'Cam hoàng hôn',
  lightTheme: FlexThemeData.light(
    scheme: FlexScheme.gold,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Arial',

  ),
  darkTheme: FlexThemeData.dark(
    scheme: FlexScheme.gold,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Arial',

  ),

);

AppTheme dellGenoaGreen = AppTheme(
  name: 'Xanh rêu',
  lightTheme: FlexThemeData.light(
    scheme: FlexScheme.dellGenoa,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Arial',

  ),
  darkTheme: FlexThemeData.dark(
    scheme: FlexScheme.dellGenoa,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Arial',

  ),
);
