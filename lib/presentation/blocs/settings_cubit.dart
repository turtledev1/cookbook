import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

enum SortOrder {
  alphabetical,
  newest,
  oldest,
}

@singleton
class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void setSortOrder(SortOrder sortOrder) {
    emit(state.copyWith(sortOrder: sortOrder));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return SettingsState(
        themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
        sortOrder: SortOrder.values[json['sortOrder'] as int? ?? 0],
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      'themeMode': state.themeMode.index,
      'sortOrder': state.sortOrder.index,
    };
  }
}

class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.sortOrder = SortOrder.alphabetical,
  });

  final ThemeMode themeMode;
  final SortOrder sortOrder;

  SettingsState copyWith({
    ThemeMode? themeMode,
    SortOrder? sortOrder,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
