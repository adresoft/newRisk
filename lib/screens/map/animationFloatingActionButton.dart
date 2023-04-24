// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:risk/screens/map/mapSettingsBottomSheet.dart';
import 'package:risk/screens/settings/settings.dart';
import 'package:risk/screens/more/more.dart';


class AnimationFloatingActionButton extends StatefulWidget {
  const AnimationFloatingActionButton({super.key});
  @override
  _AnimationFloatingActionButtonState createState() => _AnimationFloatingActionButtonState();
}

class _AnimationFloatingActionButtonState extends State<AnimationFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.indigo,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget mapSettings() {
    return FloatingActionButton(
      onPressed: () => mapSettingsBottomSheet(context),
      tooltip: 'Map Settings',
      child: Icon(Icons.map),
    );
  }

  Widget settings() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(),)),
      tooltip: 'Settings',
      child: Icon(Icons.settings),
    );
  }

  Widget more() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => More(),)),
      tooltip: 'More',
      child: Icon(Icons.more_horiz),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: mapSettings(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: settings(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: more(),
        ),
        toggle(),
      ],
    );
  }
}