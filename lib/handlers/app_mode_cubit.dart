import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../handlers/app_theme_mode.dart';
import '../screen/strings.dart';

part 'app_mode_state.dart';

class AppModeCubit extends Cubit<AppModeState> {
  AppModeCubit(String mode) : super(AppModeInitial(mode)) {
    loadMode();
  }

  Future<void> loadMode() async {
    final selectedMode = await ThemeSharedPreferences.getModeName();
    emit(AppModeUpdate(selectedMode ?? system));
  }

  Future<void> changeMode(String value) async {
    await ThemeSharedPreferences.setModeName(value);
    emit(AppModeUpdate(value));
  }
}
