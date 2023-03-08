import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/locale/base_language.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/screens/components/chart_component.dart';

import 'package:maven_class/screens/provider/provider_booking_screen.dart';
import 'package:maven_class/screens/provider/provider_home.dart';
import 'package:maven_class/screens/provider/provider_profile.dart';
import 'package:maven_class/utils/colors.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';

Languages? languages;

class ProviderDashboardScreen extends ConsumerStatefulWidget {
  late final int currentIndex;

  ProviderDashboardScreen({required this.currentIndex});
  @override
  ConsumerState<ProviderDashboardScreen> createState() =>
      _ProviderDashboardScreenState();
}


class _ProviderDashboardScreenState extends ConsumerState<ProviderDashboardScreen> {
   int currentIndex = 0;
   List<Widget> fragmentList = [
     ProviderHome(),
     ProviderBookings(),
     // ProviderAddServiceFragment(),
     ProviderProfileFragment(),
   ];
   @override
   void initState(){
     super.initState();
     currentIndex=widget.currentIndex;

   }

  @override
  Widget build(BuildContext context) {
     final data = ref.watch(bookingDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Config.appBarTitles[currentIndex],
        ),
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Work Sans",
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
      body:
      SafeArea(
        child: fragmentList[currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: primaryColor.withOpacity(0.02),
          indicatorColor: primaryColor.withOpacity(0.1),
          labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 12)),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          destinations: [
            NavigationDestination(
              icon: ImageIcon(
                AssetImage(ic_home),
                color: appTextSecondaryColor,
              ),
              // selectedIcon: ic_fill_home.iconImage(color: context.primaryColor),
              label: "Dashboard",
            ),
            NavigationDestination(
              icon: ImageIcon(AssetImage(total_booking),
                  color: appTextSecondaryColor),
              // selectedIcon: fill_ticket.iconImage(color: context.primaryColor),
              label: 'Booking',
            ),
            // NavigationDestination(
            //   icon: ImageIcon(AssetImage(un_fill_wallet),
            //       color: appTextSecondaryColor),
            //   // selectedIcon: ic_fill_wallet.iconImage(color: context.primaryColor),
            //   label: "Payment",
            // ),
            NavigationDestination(
              icon:
                  ImageIcon(AssetImage(profile), color: appTextSecondaryColor),
              // selectedIcon: ic_fill_profile.iconImage(color: context.primaryColor),
              label: "Profile",
            ),
          ],
          onDestinationSelected: (index) {
            print(index);
            setState(() {
              currentIndex = index;
              ref.invalidate(bookingDataProvider);
            });
          },
        ),
      ),
    );
  }
}
