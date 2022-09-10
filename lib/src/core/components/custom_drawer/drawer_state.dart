part of 'drawer_cubit.dart';

@immutable
abstract class DrawerState {}

class ToggleDrawerState extends DrawerState {
  final double value;

  ToggleDrawerState(this.value);
}

class ToggleDrawerInitialState extends ToggleDrawerState {
  ToggleDrawerInitialState() : super(0);
}

class OpenDrawerState extends ToggleDrawerState {
  OpenDrawerState(super.value);
}

class CloseDrawerState extends ToggleDrawerState {
  CloseDrawerState(super.value);
}
