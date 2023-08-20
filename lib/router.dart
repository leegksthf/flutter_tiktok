import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/users/custom_scroll_view_example.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
            path: UsernameScreen.routeURL,
            name: UsernameScreen.routeName,
            builder: (context, state) => const UsernameScreen(),
            routes: [
              GoRoute(
                path: EmailScreen.routeURL,
                name: EmailScreen.routeName,
                builder: (context, state) {
                  final args = state.extra as EmailScreenArgs;
                  return EmailScreen(
                    username: args.username,
                  );
                },
              ),
            ])
      ],
    ),
    // GoRoute(
    //   path: LoginScreen.routeName,
    //   builder: (context, state) => const LoginScreen(),
    // ),

    // 라우트 애니메이션 예시
    // GoRoute(
    //   name: 'username_screen',
    //   path: UsernameScreen.routeURL,
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     child: const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(
    //         opacity: animation,
    //         child: ScaleTransition(
    //           scale: animation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // ),

    GoRoute(
      path: '/users/:username',
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    )
  ],
);
