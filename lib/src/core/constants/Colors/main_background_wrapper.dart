import 'package:flutter/material.dart';
import './app_gradient.dart';

///Wrapper widget to give gradient color
class MainBackgroundWrapper extends StatelessWidget {
  ///need to pass screen as a argument
  final Widget page;

  ///Customizable Appbar
  final PreferredSizeWidget? pageAppBar;

  ///Customizable BottomNavigationBar
  final Widget? pageBottomNavigationBar;

  ///Constructor
  const MainBackgroundWrapper({
    super.key,
    this.pageAppBar,
    this.pageBottomNavigationBar,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradient.mainBackground),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: pageBottomNavigationBar,
          backgroundColor: Colors.transparent,
          appBar: pageAppBar,
          body: page),
    );
  }
}
