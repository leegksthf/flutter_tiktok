import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 상단바 색깔
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primaryColor: const Color(0xFFE9435A),
          scaffoldBackgroundColor: Colors.white,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600),
          ),
        ),
        home: const MainNavigationScreen()
        // SignUpScreen(),
        );
  }
}

// class LayoutBuilderCodeLab extends StatelessWidget {
//   const LayoutBuilderCodeLab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return MaterialApp(
//       home: Scaffold(
//         body: SizedBox(
//           width: size.width / 2,
//           // 어느정도까지 커질 수 있는지 알려줌. 부모 크기를 알 수 있음.
//           child: LayoutBuilder(
//             builder: (context, constraints) => Container(
//               width: constraints.maxWidth,
//               height: constraints.maxHeight,
//               color: Colors.teal,
//               child: Center(
//                 child: Text(
//                   '${size.width} / ${constraints.maxWidth}',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 98,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
