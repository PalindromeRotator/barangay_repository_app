import 'package:barangay_repository_app/global/responsive_sizing.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class CoreCalendar extends StatefulWidget {
  const CoreCalendar({super.key});

  @override
  State<CoreCalendar> createState() => _CoreCalendarState();
}

class _CoreCalendarState extends State<CoreCalendar> {
  int _currentSelection = 0;
  CalendarView calendarView = CalendarView.month;
  CalendarController _calendarController = CalendarController();
  final Map<int, Widget> _children = {
    0: const Text(
      'Month',
    ),
    1: const Text('Week'),
    2: const Text('Day'),
  };

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Barangay Cert', startTime, endTime));
    return meetings;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MaterialSegmentedControl(
                children: _children,
                selectionIndex: _currentSelection,
                borderColor: const Color(0xFFFECD08),
                selectedColor: Colors.white70,
                unselectedColor: const Color(0xFFFECD08),
                borderRadius: 5.0,
                disabledChildren: const [
                  3,
                ],
                onSegmentChosen: (index) {
                  setState(() {
                    _currentSelection = index;
                    switch (index) {
                      case 0:
                        calendarView = CalendarView.month;
                        break;
                      case 1:
                        calendarView = CalendarView.week;
                        break;
                      case 2:
                        calendarView = CalendarView.day;
                        break;
                      default:
                    }

                    _calendarController.view = calendarView;
                  });
                },
              ))),
      Expanded(
          flex: 5,
          child: SfCalendar(
            controller: _calendarController,
            headerStyle: const CalendarHeaderStyle(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFFFECD08),
            ),
            view: calendarView,
            dataSource: MeetingDataSource(_getDataSource()),
            // by default the month appointment display mode set as Indicator, we can
            // change the display mode as appointment using the appointment display
            // mode property
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          )),
    ]);
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;
}
