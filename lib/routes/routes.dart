
import 'package:flutter/cupertino.dart';
import 'package:patient_app/routes/routes_name.dart';
import 'package:patient_app/screens/select_doctor_screen.dart';

import '../core/screens/error_screen.dart';
import '../screens/form_page_screen.dart';


class Routes {
  Routes._();
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {


      case RoutesName.selectDoctor:
        return _cupertinoRoute(const SelectDoctorScreen());

      case RoutesName.formPage:
      // Retrieve the doctorUid argument
        final doctorUid = settings.arguments as String?;

        if (doctorUid != null) {
          return _cupertinoRoute(FormPageScreen(doctorUid: doctorUid)); // Pass the doctorUid to FormPageScreen
        } else {
          return _cupertinoRoute(const ErrorScreen(
            error: 'Doctor UID is missing for Form Page',
          )); // Show error screen if doctorUid is missing
        }







      default:
        return _cupertinoRoute(
          ErrorScreen(
            error: 'Wrong Route provided ${settings.name}',
          ),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );
}
