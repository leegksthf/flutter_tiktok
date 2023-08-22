import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/videos/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const VideoRecordingScreen(),
    )

    // GoRoute(
    //   path: SignUpScreen.routeName,
    //   builder: (context, state) => const SignUpScreen(),
    // ),
    // GoRoute(
    //   path: LoginScreen.routeName,
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   path: UsernameScreen.routeName,
    //   builder: (context, state) => const UsernameScreen(),
    // ),
    // GoRoute(
    //   path: EmailScreen.routeName,
    //   builder: (context, state) {
    //     final args = state.extra as EmailScreenArgs;
    //     return EmailScreen(
    //       username: args.username,
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/users/:username',
    //   builder: (context, state) {
    //     final username = state.params['username'];
    //     final tab = state.queryParams['show'];
    //     return UserProfileScreen(username: username!, tab: tab!);
    //   },
    // ),
  ],
);
