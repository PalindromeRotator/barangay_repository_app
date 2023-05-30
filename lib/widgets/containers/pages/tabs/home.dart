import 'package:barangay_repository_app/global/responsive_sizing.dart';
import 'package:barangay_repository_app/widgets/core/core_calendar/core_calendar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSizing responsiveSizing = ResponsiveSizing(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveSizing.calc_width(10),
                vertical: responsiveSizing.calc_height(10)),
            child: const CoreCalendar()));
  }
}
