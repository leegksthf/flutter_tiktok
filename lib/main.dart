import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 상단바 색깔
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // S.load(const Locale('en'));
    // flexColorScheme 패키지로 편하게 설정할 수 있음.
    return VideoConfig(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ko'),
        ],
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          // font와 color만 지정해주고, size나 weight등의 속성은 지정해주지 않음.
          textTheme: Typography.blackMountainView,
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
            surfaceTintColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),

          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
          // icon마다 색 지정해주지 말고 iconTheme으로 한꺼번에 지정해주면 됨.
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.whiteMountainView,
          // GoogleFonts.notoSansTextTheme(
          //   ThemeData(brightness: Brightness.dark).textTheme,
          // ),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.grey.shade900,
            backgroundColor: Colors.grey.shade900,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          primaryColor: const Color(
            0xFFE9435A,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade700,
          ),
        ),
        // home: const SignUpScreen(),
      ),
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
