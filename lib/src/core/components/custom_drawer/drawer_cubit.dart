import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<ToggleDrawerState> {
  DrawerCubit() : super(ToggleDrawerInitialState());

  double _indicator = 0;

  static DrawerCubit get(BuildContext context) => BlocProvider.of(context);

  double get value => _indicator;

  openDrawer() {
    if (_indicator == 0) {
      _indicator = 1;
      emit(OpenDrawerState(_indicator));
    }
  }

  closeDrawer() {
    if (_indicator == 1) {
      _indicator = 0;
      emit(CloseDrawerState(_indicator));
    }
  }
}
