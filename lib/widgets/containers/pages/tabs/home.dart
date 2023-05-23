import 'package:barangay_repository_app/global/responsive_sizing.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ResponsiveSizing responsiveSizing = ResponsiveSizing(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveSizing.calc_width(10),
                vertical: responsiveSizing.calc_height(10)),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            )));
  }
}
