import 'package:flutter/material.dart';

/// Returns true if the device is a tablet based on screen width.
bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.shortestSide >= 600;
}

/// Returns true if the device is a mobile phone based on screen width.
bool isMobile(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.shortestSide < 600;
}