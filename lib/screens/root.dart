import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/navigation_provider.dart';
import 'package:ktu_sosyal/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signin_signup.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      if (authProvider.isSignedIn) {
        return _buildScreens();
      } else {
        return SignInSignUp();
      }
    });
  }
}

// Widget _buildFloatingActionButtonIcon() {
//   return Material(
//     type: MaterialType.transparency,
//     child: Ink(
//       decoration: BoxDecoration(
//         border: Border.all(color: KtuColors.ktuLightBlue, width: 2.0),
//         color: KtuColors.ktuWhite,
//         shape: BoxShape.circle,
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(1000.0),
//         onTap: () {
//         },
//         child: Padding(
//           //Padding works weirdly
//           padding: EdgeInsets.fromLTRB(3, 3, 10, 10),
//           child: Icon(
//             Icons.add,
//             size: 45.0,
//             color: KtuColors.ktuDarkBlue,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// AppBar _buildAppBar(BuildContext context) {

//   //final _auth = AuthService(FirebaseAuth.instance);
//   return AppBar(
//     automaticallyImplyLeading: false,
//     backgroundColor: KtuColors.ktuLightBlue,
//     title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
//     leading: Builder(
//       builder: (BuildContext context) => IconButton(
//         icon: SvgPicture.asset(
//           LogoConstants.drawerIcon,
//           width: 30.0,
//         ),
//         onPressed: () => Scaffold.of(context).openDrawer(),
//       ),
//     ),
//     centerTitle: true,
//   );
// }

Widget _buildScreens() {
  return Builder(
    builder: (BuildContext context) => Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        // Create bottom navigation bar items from screens.
        final bottomNavigationBarItems = navigationProvider.screens
            .map((screen) => BottomNavigationBarItem(
                icon: _buildNavigationBarIcons(screen.label),
                label: screen.label))
            .toList();

        // Initialize [Navigator] instance for each screen.
        final screens = navigationProvider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return WillPopScope(
          onWillPop: () async => navigationProvider.onWillPop(context),
          child: Scaffold(
            drawer: Drawer(
              child: BuildDrawerBar(context),
            ),
            // appBar: _buildAppBar(context),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   child: _buildFloatingActionButtonIcon(),
            // ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            body: IndexedStack(
              children: screens,
              index: navigationProvider.currentTabIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavigationBarItems,
              currentIndex: navigationProvider.currentTabIndex,
              onTap: (tab) {
                navigationProvider.setTab(tab, context);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: KtuColors.ktuLightBlue,
              // Doesn't work.
              unselectedItemColor: KtuColors.ktuDarkBlue,
              selectedItemColor: KtuColors.ktuWhite,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildNavigationBarIcons(String label) {
  switch (label) {
    case 'Ana Sayfa':
      return SvgPicture.asset(LogoConstants.homeIcon, width: 23.0);
    case 'Arama':
      return SvgPicture.asset(LogoConstants.searchIcon, width: 28.0);
    case 'Duyuru':
      return SvgPicture.asset(LogoConstants.notificationIcon,
          width: 24, height: 30, color: Colors.white);
    case 'Topluluk':
      return SvgPicture.asset(LogoConstants.groupIcon, width: 29.0);
    default:
      return SvgPicture.asset(LogoConstants.homeIcon, width: 23.0);
  }
}
