import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/Model/model.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart';

class medsNotification extends StatefulWidget {
  final String keys;

  const medsNotification({required this.keys});

  @override
  State<medsNotification> createState() => _medsNotificationState();
}

class _medsNotificationState extends State<medsNotification> {
  late List<Medicine> medicines = [];
  late DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    print('keys: ${widget.keys}');
    fetchMedicines();
    super.initState();
  }

  Future<void> fetchMedicines() async {
    List<Medicine> allMedicines = await DatabaseHelper.fetchMedicines();
    List<Medicine> filteredMedicines =
        allMedicines.where((medicine) => medicine.keys == widget.keys).toList();

    // Filter medicines based on the current time
    DateTime now = DateTime.now();
    filteredMedicines = filteredMedicines
        .where((medicine) => (medicine.time.hour == now.hour &&
            medicine.time.minute == now.minute))
        .toList();

    // Subtract dose from total dose and update total dose
    for (Medicine medicine in filteredMedicines) {
      if (medicine.TotalDose > 0) {
        medicine.TotalDose -= medicine.dose;
        // Update the total dose in the database
        DatabaseHelper.updateMedicine(Medicine(
            name: medicine.name,
            dose: medicine.dose,
            TotalDose:  medicine.TotalDose,
            type: medicine.type,
            startDate: medicine.startDate,
            endDate: medicine.endDate,
            time: medicine.time,
            Remind: medicine.Remind,
            Repeat: medicine.Repeat,
            keys: widget.keys));
        print('Medicine dose updated ${medicine.TotalDose}');
      }
    }

    setState(() {
      medicines = filteredMedicines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Medicine Reminder',
            ),
          ],
        ),
      ),
    );
  }
}
