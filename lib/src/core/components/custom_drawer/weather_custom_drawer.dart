import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/components/custom_drawer/drawer_cubit.dart';

class WeatherCustomDrawer extends StatelessWidget {
  const WeatherCustomDrawer({
    Key? key,
    required this.child,
    required this.drawer,
  }) : super(key: key);
  final Widget child;
  final Widget drawer;

  static void toggleDrawer(BuildContext context) {
    try {
      final isOpen = DrawerCubit.get(context).value == 1;
      if (isOpen) {
        DrawerCubit.get(context).closeDrawer();
      } else {
        DrawerCubit.get(context).openDrawer();
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DrawerCubit(),
      child: BlocConsumer<DrawerCubit, ToggleDrawerState>(
        listener: (BuildContext context, state) {
          debugPrint(
            state is OpenDrawerState
                ? "Open Drawer Called"
                : "Close Drawer Called",
          );
        },
        builder: (BuildContext context, ToggleDrawerState state) {
          return Stack(
            children: [
              drawer,
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: state.value),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                builder: (_, double val, __) {
                  return Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..setEntry(0, 3, 360 * val),
                    child: child,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
