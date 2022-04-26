import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../../constants.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit() : super(const AppbarArgs(kLandingPageColor, ktextColor));

  void updateAppBarArgs(Color bgColor, txtColor) {
    emit(AppbarArgs(bgColor, txtColor));
  }
}
