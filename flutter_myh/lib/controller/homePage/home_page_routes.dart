import 'package:flutter/material.dart';

import 'home_detail_vc.dart';
import '../demo/padding_align_center_demo.dart';
import '../demo/send_demo.dart';
import '../demo/subject_page.dart';
import '../demo/container_demo.dart';

class HomePageRoutes {
  static String routeName = 'home';
  static String detail = routeName + 'detail';
  static String paddingAlignCenter = routeName + 'paddingAlignCenter';
  static String sendDemo = routeName + 'sendDemo';
  static String subjectPage = routeName + 'subjectpage';
  static String containerDemo = routeName + 'containerDemo';

  static getHomePageRoutes(BuildContext context) {
    return <String, Widget Function(BuildContext)>{
      detail: (_) => HomeDetailVC(model: null),
      paddingAlignCenter: (_) => PaddingAlignCenter(),
      sendDemo: (_) => SendActivity(),
      subjectPage: (_) => SubjectPage(),
      containerDemo: (_) => ContainerDemo(),
    };
  }
}
