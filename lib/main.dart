import 'package:device_preview/device_preview.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:dot_com/subadmin/home/presentation/subadmin_home.dart';
import 'package:dot_com/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:dot_com/admin/home/admin_home.dart';
import 'package:dot_com/auth/screen/login/login_page.dart';
import 'package:dot_com/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/viewModel/auth_viewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// void main() => runApp(
//       DevicePreview(
//         builder: (context) => MyApp(), // Wrap your app
//       ),
//     );

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: _getUserRole(), // Fetch the user role from SharedPreferences
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else {
//           final String role = snapshot.data ?? '';
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Flutter Demo',
//             theme: ThemeData(
//               colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//               useMaterial3: true,
//             ),
//             initialRoute: role != '' ? _getInitialRoute(role) : Routes.loginScreen,
//             onGenerateRoute: Routes.controller,
//           );
//         }
//       },
//     );
//   }
//
//   static Future<String> _getUserRole() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('role') ?? ''; // Get role from SharedPreferences
//   }
//
//   static String _getInitialRoute(String role) {
//     switch (role) {
//       case 'Customer':
//         return Routes.ClientScreen; // Navigate to client page if role is Customer
//       case 'Admin':
//         return Routes.AdminScreen; // Navigate to admin page if role is Admin
//       default:
//         return Routes.loginScreen; // Navigate to login page for any other role
//     }
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: _getUserRole(), // Fetch the user role from SharedPreferences
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else {
//           final String role = snapshot.data ?? '';
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'DotCom.Sale',
//             theme: ThemeData(
//               colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//               useMaterial3: true,
//             ),
//             initialRoute: role != '' ? _getInitialRoute(role) : Routes.ClientScreen,
//             onGenerateRoute: Routes.controller,
//           );
//         }
//       },
//     );
//   }
//
//   static Future<String> _getUserRole() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('role') ?? ''; // Get role from SharedPreferences
//   }
//
//   static String _getInitialRoute(String role) {
//     switch (role) {
//       case 'Customer':
//         return Routes.ClientScreen; // Navigate to client page if role is Customer
//       case 'Admin':
//         return Routes.AdminScreen; // Navigate to admin page if role is Admin
//       default:
//         return Routes.loginScreen; // Navigate to login page for any other role
//     }
//   }
// }

class MyApp extends StatelessWidget {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('token', "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHBpcnlEYXRlIjoxNzE0Mzc5MzkyOTI2LCJyb2xlIjoiU3ViQWRtaW4iLCJtb2JpbGVOdW1iZXIiOiIxMjIxMTU2Nzg5MSIsImlzcyI6ImRvdENvbSIsImlkIjo3MiwidXNlck5hbWUiOiJKb2huIERvZSIsImVtYWlsIjoicXdlZXdxIn0.6BSPMZI0LWxb1qibp4JmcUwf7vKapiR-lY7fAfgHuoQ");
  // prefs.setString('role', "SubAdmin");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final String role = snapshot.data ?? '';
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DotCom.Sale',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            initialRoute: role != '' ? _getInitialRoute(role) : Routes.ClientScreen,
            onGenerateRoute: Routes.controller,
          );
        }
      },
    );

    return GetMaterialApp(
      // scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'DotCom.Sale',
      initialRoute: Routes.loginScreen,
      onGenerateRoute: Routes.controller,
    );
  }

  static Future<String> _getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? ''; // Get role from SharedPreferences
  }

  static String _getInitialRoute(String role) {
    switch (role) {
      case 'Customer':
        return Routes.ClientScreen; // Navigate to client page if role is Customer
      case 'Admin':
        return Routes.AdminScreen; // Navigate to admin page if role is Admin
      case 'SubAdmin':
        return Routes.SubAdminScreen;
      default:
        return Routes.loginScreen; // Navigate to login page for any other role
    }
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SubAdminHomeWrapper();
// }}

// return MaterialApp(
//   debugShowCheckedModeBanner: false,
//   title: 'DotCom.Sale',
//   initialRoute: Routes.cartScreen,
//   onGenerateRoute: Routes.controller,
// );
