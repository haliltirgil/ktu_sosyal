import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/announcement_provider.dart';
import 'package:ktu_sosyal/providers/faculty_provider.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/providers/help_page_provider.dart';
import 'package:ktu_sosyal/providers/navigation_provider.dart';
import 'package:ktu_sosyal/providers/post_provider.dart';
import 'package:ktu_sosyal/providers/reply_provider.dart';
import 'package:ktu_sosyal/providers/signin_validation_provider.dart';
import 'package:ktu_sosyal/screens/init_screen.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (context) => HelpPageProvider()),
        ChangeNotifierProvider(create: (context) => FacultyProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ReplyProvider()),
        ChangeNotifierProvider(create: (context) => SignInValidation()),
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(ThemeData.light()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialAppWithTheme();
        },
      ),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        theme: theme.getTheme(),
        onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
        home: InitScreen());
  }
}
