import 'package:e_waste/presentation/dashboard/home_screen.dart';
import 'package:e_waste/presentation/dashboard/reward_components/leaderboard_screen.dart';
import 'package:e_waste/presentation/dashboard/reward_components/point_history_screen.dart';
import 'package:e_waste/presentation/dashboard/reward_components/reward_details_screen.dart';
import 'package:e_waste/presentation/views/auth/auth_screen.dart';
import 'package:e_waste/presentation/views/camera_screen.dart';
import 'package:e_waste/presentation/views/navigation_screen.dart';
import 'package:e_waste/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
//
// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case '/home':
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case '/auth':
//         return MaterialPageRoute(builder: (_) => const AuthScreen());
//       case '/nav':
//         return MaterialPageRoute(builder: (_) => const NavigationScreen());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(
//                   body: Center(
//                       child: Text('No route defined for ${settings.name}')),
//                 ));
//     }
//   }
// }

class RouteNavigation {
  static const String splashScreenRoute = '/';
  static const String homeScreenRoute = '/home';
  static const String authScreenRoute = '/auth';
  static const String navScreenRoute = '/nav';
  static const String leaderboardScreenRoute = '/leaderboard';
  static const String cameraScreenRoute = '/cam';
  static const String pointHistoryScreenRoute = '/pointHistory';
  static const String rewardHistoryScreenRoute = '/rewardHistory';
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:
        return _customFadeRoute(child: const SplashScreen());
      case authScreenRoute:
        return _customFadeRoute(child: const AuthScreen());
      case leaderboardScreenRoute:
        return _customFadeRoute(child: const LeaderboardScreen());
      case pointHistoryScreenRoute:
        return _customFadeRoute(child: const PointHistoryScreen());
      case rewardHistoryScreenRoute:
        return _customFadeRoute(child: const RewardDetailsScreen());
      case cameraScreenRoute:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _customFadeRoute(
            child: CameraScreen(
          base64Image: args["base64Image"],
        ));
      // case homeScreenRoute:
      //   return _customFadeRoute(child: const HomeScreen());

      // case resetPasswordScreenRoute:
      //   final args = settings.arguments as Map<String, dynamic>? ?? {};
      //   return _customFadeRoute(
      //       child: ResetPasswordScreen(
      //         username: args["username"],
      //         codeDeliveryDetails: args["codeDeliveryDetails"],
      //       ));

      case navScreenRoute:
        return _customFadeRoute(child: NavigationScreen());

      // case ConfirmScreenRoute:
      //   return _customFadeRoute(child: const ConfirmScreen());

      // case homeScreenRoute:
      //   return _customFadeRoute(child: HomeScreen());
      //
      // case profileScreenRoute:
      //   return _customFadeRoute(child: ProfileScreen());
      // case playScreenRoute:
      //   final args = settings.arguments as PlayScreen;
      //   return _customFadeRoute(
      //       child: PlayScreen(
      //         initialSchedule: args.initialSchedule,
      //       ));
      default:
        return GetPageRoute(
          page: () => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        );
    }
  }

  static PageTransition _customFadeRoute({required child}) {
    return PageTransition(
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
