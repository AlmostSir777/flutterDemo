import 'package:flutter/material.dart';

enum animationType {
  none,
  fade,
  rotation,
  scale,
  slider,
}

class AnimationCustomRoute extends PageRouteBuilder {
  final Widget widget;
  animationType type;
  AnimationCustomRoute({
    @required this.widget,
    this.type = animationType.fade,
  }) : super(
          transitionDuration: type == animationType.none
              ? Duration(milliseconds: 1)
              : Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            Widget value;
            switch (type) {
              case animationType.none:
                {
                  value = child;
                }
                break;
              case animationType.fade:
                {
                  value = FadeTransition(
                    opacity:
                        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1,
                      curve: Curves.fastOutSlowIn,
                    )),
                    child: child,
                  );
                }
                break;
              case animationType.rotation:
                {
                  value = RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1,
                      curve: Curves.fastOutSlowIn,
                    )),
                    child: ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    ),
                  );
                }
                break;
              case animationType.scale:
                {
                  value = ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation1, curve: Curves.fastOutSlowIn)),
                      child: child);
                }
                break;
              case animationType.slider:
                {
                  value = SlideTransition(
                    position: Tween<Offset>(
                            begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                        .animate(CurvedAnimation(
                            parent: animation1, curve: Curves.fastOutSlowIn)),
                    child: child,
                  );
                }
                break;
              default:
            }
            return value;
          },
        );
}
