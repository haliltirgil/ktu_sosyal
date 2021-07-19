import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ktu_sosyal/screens/comments_screen.dart';
import 'package:ktu_sosyal/screens/group_detail_screen.dart';
import 'package:ktu_sosyal/screens/help_screen.dart';
import 'package:ktu_sosyal/screens/members_screen.dart';
import 'package:ktu_sosyal/screens/message_screen.dart';
import 'package:ktu_sosyal/screens/post_screen.dart';
import 'package:ktu_sosyal/screens/profile_screen.dart';
import 'package:ktu_sosyal/screens/root.dart';
import 'package:ktu_sosyal/screens/send_post_screen.dart';
import 'package:ktu_sosyal/screens/settings_details/settings_about_screen.dart';
import 'package:ktu_sosyal/screens/settings_details/settings_account_screen.dart';
import 'package:ktu_sosyal/screens/settings_details/settings_security_screen.dart';
import 'package:ktu_sosyal/screens/settings_details/settings_theme_screen.dart';
import 'package:ktu_sosyal/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:ktu_sosyal/models/screen_model.dart';
import 'package:ktu_sosyal/screens/home_screen.dart';
import 'package:ktu_sosyal/screens/search_screen.dart';
import 'package:ktu_sosyal/screens/notification_screen.dart';
import 'package:ktu_sosyal/screens/group_screen.dart';

const HOME_SCREEN = 0;
const SEARCH_SCREEN = 1;
const NOTIFICATION_SCREEN = 2;
const GROUP_SCREEN = 3;

class NavigationProvider with ChangeNotifier {
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = HOME_SCREEN;

  final Map<int, Screen> _screens = {
    HOME_SCREEN: Screen(
      label: 'Ana Sayfa',
      child: HomeScreen(),
      initialRoute: HomeScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case CommentScreen.route:
            return MaterialPageRoute(
                builder: (_) => CommentScreen(
                    map: settings.arguments as Map<String, String>?));
          case ProfileScreen.route:
            return MaterialPageRoute(
                builder: (_) => ProfileScreen(
                    map: settings.arguments as Map<String, String>?));
          case NotificationScreen.route:
            return MaterialPageRoute(builder: (_) => NotificationScreen());
          case GroupScreen.route:
            return MaterialPageRoute(builder: (_) => GroupScreen());
          case SendPostScreen.route:
            return MaterialPageRoute(builder: (_) => SendPostScreen());
          case SettingsScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsScreen());
          case HelpScreen.route:
            return MaterialPageRoute(builder: (_) => HelpScreen());
          case SettingsAboutScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAboutScreen());
          case SettingsAccountScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAccountScreen());
          case SettingsSecurityScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsSecurityScreen());
          case SettingsThemeScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsThemeScreen());
          case MembersScreen.route:
            return MaterialPageRoute(
                builder: (_) => MembersScreen(
                    map: settings.arguments as Map<String, String>?));
          case PostScreen.route:
            return MaterialPageRoute(
                builder: (_) => PostScreen(
                    map: settings.arguments as Map<String, String>?));
          case GroupDetailScreen.route:
            return MaterialPageRoute(
                builder: (_) => GroupDetailScreen(
                    map: settings.arguments as Map<String, String>));
          // case PushedScreen.route:
          //   return MaterialPageRoute(builder: (_) => PushedScreen());
          default:
            return MaterialPageRoute(builder: (_) => HomeScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    SEARCH_SCREEN: Screen(
      label: 'Arama',
      child: SearchScreen(),
      initialRoute: SearchScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case GroupDetailScreen.route:
            return MaterialPageRoute(
                builder: (_) => GroupDetailScreen(
                    map: settings.arguments as Map<String, String>));
          case PostScreen.route:
            return MaterialPageRoute(
                builder: (_) => PostScreen(
                    map: settings.arguments as Map<String, String>?));
          case CommentScreen.route:
            return MaterialPageRoute(
                builder: (_) => CommentScreen(
                    map: settings.arguments as Map<String, String>?));
          case ProfileScreen.route:
            return MaterialPageRoute(
                builder: (_) => ProfileScreen(
                    map: settings.arguments as Map<String, String>?));
          case MembersScreen.route:
            return MaterialPageRoute(
                builder: (_) => MembersScreen(
                    map: settings.arguments as Map<String, String>?));
          case NotificationScreen.route:
            return MaterialPageRoute(builder: (_) => NotificationScreen());
          case GroupScreen.route:
            return MaterialPageRoute(builder: (_) => GroupScreen());
          case SettingsScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsScreen());
          case HelpScreen.route:
            return MaterialPageRoute(builder: (_) => HelpScreen());
          case SettingsAboutScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAboutScreen());
          case SettingsAccountScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAccountScreen());
          case SettingsSecurityScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsSecurityScreen());
          case SettingsThemeScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsThemeScreen());
          default:
            return MaterialPageRoute(builder: (_) => SearchScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    NOTIFICATION_SCREEN: Screen(
      label: 'Duyuru',
      child: NotificationScreen(),
      initialRoute: NotificationScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case ProfileScreen.route:
            return MaterialPageRoute(
                builder: (_) => ProfileScreen(
                    map: settings.arguments as Map<String, String>?));
          case NotificationScreen.route:
            return MaterialPageRoute(builder: (_) => NotificationScreen());
          case GroupScreen.route:
            return MaterialPageRoute(builder: (_) => GroupScreen());
          case SettingsScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsScreen());
          case HelpScreen.route:
            return MaterialPageRoute(builder: (_) => HelpScreen());
          case SettingsAboutScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAboutScreen());
          case SettingsAccountScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAccountScreen());
          case SettingsSecurityScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsSecurityScreen());
          case SettingsThemeScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsThemeScreen());
          default:
            return MaterialPageRoute(builder: (_) => NotificationScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    GROUP_SCREEN: Screen(
      label: 'Topluluk',
      child: GroupScreen(),
      initialRoute: GroupScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case CommentScreen.route:
            return MaterialPageRoute(
                builder: (_) => CommentScreen(
                    map: settings.arguments as Map<String, String>?));
          case ProfileScreen.route:
            return MaterialPageRoute(
                builder: (_) => ProfileScreen(
                    map: settings.arguments as Map<String, String>?));
          case NotificationScreen.route:
            return MaterialPageRoute(builder: (_) => NotificationScreen());
          case GroupScreen.route:
            return MaterialPageRoute(builder: (_) => GroupScreen());
          case SettingsScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsScreen());
          case HelpScreen.route:
            return MaterialPageRoute(builder: (_) => HelpScreen());
          case MembersScreen.route:
            return MaterialPageRoute(
                builder: (_) => MembersScreen(
                    map: settings.arguments as Map<String, String>?));
          case GroupDetailScreen.route:
            return MaterialPageRoute(
                builder: (_) => GroupDetailScreen(
                    map: settings.arguments as Map<String, String>));
          case PostScreen.route:
            return MaterialPageRoute(
                builder: (_) => PostScreen(
                    map: settings.arguments as Map<String, String>?));
          case CommentScreen.route:
            return MaterialPageRoute(
                builder: (_) => CommentScreen(
                    map: settings.arguments as Map<String, String>?));
          case SettingsAboutScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAboutScreen());
          case SettingsAccountScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsAccountScreen());
          case SettingsSecurityScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsSecurityScreen());
          case SettingsThemeScreen.route:
            return MaterialPageRoute(builder: (_) => SettingsThemeScreen());
          default:
            return MaterialPageRoute(builder: (_) => GroupScreen());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  int get currentTabIndex => _currentScreenIndex;
  List<Screen> get screens => _screens.values.toList();
  Screen get currentScreen => _screens[_currentScreenIndex]!;

  void setTab(int tab, context) async {
    if (tab == currentTabIndex) {
      _scrollToStart(tab);
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name!) {
      // We can push another screen  here, like settings
      case SettingsScreen.route:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case HelpScreen.route:
        return MaterialPageRoute(builder: (_) => HelpScreen());
      case ProfileScreen.route:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case MessageScreen.route:
        return MaterialPageRoute(builder: (_) => MessageScreen());
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != HOME_SCREEN) {
        setTab(HOME_SCREEN, context);
        notifyListeners();
        return false;
      } else {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      }
    }
  }

  void _scrollToStart(int tab) async {
    if (currentScreen.scrollController != null &&
        currentScreen.scrollController!.hasClients) {
      await currentScreen.scrollController!.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
    // if (currentScreen. != _screens[tab]!.initialRoute) {
    //   print("true");
    // }
  }
}
