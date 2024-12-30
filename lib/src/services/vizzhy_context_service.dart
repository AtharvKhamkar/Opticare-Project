import 'package:flutter/material.dart';

/// this service file can be used to get BuildContext
/// anywhere in the application
/// for eg : Controller/BLOC
/// call VizzhyContextService.context
/// Note : Context can be null for some cases
class VizzhyContextService {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  /// get navigatorKey and assign to Materialapp function
  static GlobalKey<NavigatorState> get navigatorKey => _navKey;

  /// returns Builcontext
  static BuildContext? get context =>
      navigatorKey.currentState?.overlay?.context;
}
