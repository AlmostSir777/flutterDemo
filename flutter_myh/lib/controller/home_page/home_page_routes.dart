import 'package:flutter/material.dart';

import '../demo/home/home_detail_vc.dart';
import '../demo/home/padding_align_center_demo.dart';
import '../demo/home/send_demo.dart';
import '../demo/home/subject_page.dart';
import '../demo/setting/container_demo.dart';
import '../demo/home/draw_graphical.dart';
import '../demo/home/animation_test_demo.dart';

class HomePageRoutes {
  static String routeName = 'home';
  static String detail = routeName + 'detail';
  static String paddingAlignCenter = routeName + 'paddingAlignCenter';
  static String sendDemo = routeName + 'sendDemo';
  static String subjectPage = routeName + 'subjectpage';
  static String containerDemo = routeName + 'containerDemo';
  static String graphicalDemo = routeName + 'graphicalDemo';
  static String animationDemo = routeName + 'animationDemo';
  static String customAnimationDemo = routeName + 'customAnimationDemo';

  static getHomePageRoutes(BuildContext context) {
    return <String, Widget Function(BuildContext)>{
      detail: (_) => HomeDetailVC(),
      sendDemo: (_) => SendActivity(),
      containerDemo: (_) => ContainerDemo(),
      graphicalDemo: (_) => DrawDemo(),
      // animationDemo: (_) => AnimationTestDemo(),
    };
  }

  static getCustomPageRoutes() {
    return {
      subjectPage: SubjectPage(),
      paddingAlignCenter: PaddingAlignCenter(),
      animationDemo: AnimationTestDemo(),
      customAnimationDemo: CustomAnimationDemo(),
    };
  }
}
