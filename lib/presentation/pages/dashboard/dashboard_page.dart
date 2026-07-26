import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/dashboard/methods/announcement_banner.dart';
import 'package:xlerate/presentation/pages/dashboard/methods/dashboard_header.dart';
import 'package:xlerate/presentation/pages/dashboard/methods/program_list.dart';
import 'package:xlerate/presentation/providers/programs/programs_list_provider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final programListData = ref.watch(programsListProvider);

    return Scaffold(
      body: ListView(
        children: [
          // * Header
          dashboardHeader(context),

          // * Announcement Banner
          announcementBanner(
            context,
            currentIndex: _currentIndex,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),

          // * Programs List
          programList(context, programListData),

          verticalSpaces(50),
        ],
      ),
    );
  }
}
