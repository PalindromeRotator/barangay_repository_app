import 'package:barangay_repository_app/firebase_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int _selectedPriority = 1;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  final TextEditingController _certificateController =
      new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseQuery firebaseQuery = FirebaseQuery();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Appointment Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _certificateController,
                  decoration: const InputDecoration(
                    labelText: 'Certificate/Appointment',
                    border: OutlineInputBorder(),
                  ),
                ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   maxLines: 3,
                //   decoration: const InputDecoration(
                //     labelText: 'Description',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                const SizedBox(height: 16),
                // const Text(
                //   'Priority',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 16),
                // Wrap(
                //   spacing: 8.0,
                //   children: [
                //     _buildPriorityButton(1, Icons.low_priority),
                //     _buildPriorityButton(2, Icons.priority_high),
                //     _buildPriorityButton(3, Icons.block),
                //   ],
                // ),
                // const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectStartDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Start Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectEndDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'End Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle save appointment logic
                    firebaseQuery.appointOrRequestAppointment(
                        {_certificateController.text, _startDate, _endDate},
                        _auth.currentUser!.uid);
                  },
                  child: const Text('Save Appointment'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFECD08),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityButton(int priority, IconData iconData) {
    return ChoiceChip(
      label: Icon(iconData),
      selected: _selectedPriority == priority,
      onSelected: (bool selected) {
        setState(() {
          _selectedPriority = selected ? priority : 1;
        });
      },
    );
  }
}
