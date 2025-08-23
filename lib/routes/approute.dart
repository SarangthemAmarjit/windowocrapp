// 📦 Package imports:

import 'package:camera_windows_example/home/idselectionpage.dart' show DocumentScanPage;
import 'package:camera_windows_example/home/registration.dart';
import 'package:camera_windows_example/home/registrationpages/succespage.dart';
import 'package:camera_windows_example/routes/shellroutewrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home/welcomepage.dart';
import '../payment/PaymentPage.dart';
import '../widgets/errorwidget.dart';

abstract class AcnooAppRoutes {
  //--------------Navigator Keys--------------//
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static const _initialPath = '/';
  static final routerConfig = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: _initialPath,
    routes: [
      GoRoute(
        path: _initialPath,
        redirect: (context, state) {
          if (state.uri.path.contains('/home')) {
            return state.uri.path;
          }
          return '/home/homescreen';
        },
      ),
      ShellRoute(
        navigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: Shellroutewrapper(child: child));
        },
        routes: [
          // Dashboard Routes
          GoRoute(
            path: '/home',
            redirect: (context, state) async {
              if (state.fullPath == '/home') {
                return state.fullPath;
              }
              return null;
            },
            routes: [
              GoRoute(
                path: 'homescreen',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: WelcomeScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'idverification',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: DocumentScanPage(),
                  );
                },
              ),
              GoRoute(
                path: 'registration',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: RegistrationPage(),
                  );
                },
              ),
              GoRoute(
                path: 'paymentpage',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: PaymentFinalPage(),
                  );
                },
              ),
              GoRoute(
                path: 'successpage',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: Successpages(),
                  );
                },
              )
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(child: ErrorPages()),
  );
}
