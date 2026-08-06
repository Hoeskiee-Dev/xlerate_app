// file: presentation/pages/main/main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:xlerate/presentation/pages/productivity/productivity_screen.dart';
import 'package:xlerate/presentation/pages/program/program_list/program_list_screen.dart';
import 'package:xlerate/presentation/providers/user_provider.dart';

/// The root scaffold container managing bottom navigation tabs and dynamic
/// role-based view permissions (Admin vs Learner) using Riverpod state.
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  // Tracks the currently selected bottom navigation index
  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 1. Read the live user state from Riverpod userProvider
    final user = ref.watch(userProvider);

    // 2. Dynamically check if the logged-in user holds an 'admin' role
    final bool isAdmin = user?.role.toLowerCase() == 'admin';

    // 3. Build dynamic screens list based on user privileges
    final List<Widget> screens = [
      const DashboardPage(),
      ProgramListScreen(
        isAdmin:
            isAdmin, // Passes true for admin privileges, false for learners
      ),
      const ProductivityScreen(),
    ];

    return Scaffold(
      extendBody:
          true, // Allows content to flow seamlessly behind the floating navigation bar
      body: IndexedStack(
        index: _screenIndex,
        children: screens, // Preserves state across tab switches
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Center(child: _buildNavItem(Icons.home_rounded, 0)),
              ),
              Expanded(
                child: Center(child: _buildNavItem(Icons.list_alt_rounded, 1)),
              ),
              Expanded(
                child: Center(
                  child: _buildNavItem(Icons.calendar_month_rounded, 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget to build individual custom styled bottom navigation icons.
  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _screenIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _screenIndex = index; // Switches active tab index
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepOrangeAccent.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? Colors.deepOrange : Colors.grey.shade400,
        ),
      ),
    );
  }
}
