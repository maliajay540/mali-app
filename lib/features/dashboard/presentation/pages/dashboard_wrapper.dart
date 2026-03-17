import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/dashboard_bottom_nav_bar.dart';

class DashboardWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: DashboardBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(index); 
        },
      ),
    );
  }
}