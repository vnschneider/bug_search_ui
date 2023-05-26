import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

Widget customSwitchButton(
    Function(bool) function, bool isSwitched, double height, double width) {
  return FlutterSwitch(
    toggleSize: 42,
    height: height, //48,
    width: width, //84
    borderRadius: 50,
    padding: 6,
    inactiveColor: const Color(0xff4766EA),
    activeColor: const Color(0xFF000000),
    inactiveIcon: const Icon(
      BootstrapIcons.brightness_low,
      //size: 44,
      color: Color(0xff4766EA),
    ),
    activeIcon: const Icon(
      BootstrapIcons.moon,
      //size: 44,
      color: Colors.black,
    ),
    duration: const Duration(milliseconds: 300),
    value: isSwitched,
    onToggle: function,
  );
}
