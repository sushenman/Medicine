import 'package:flutter/material.dart';

import 'package:medicine_reminder/Model/model.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart';
import 'package:medicine_reminder/local_notification.dart';

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
print(filteredMedicines.toList());
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
      await DatabaseHelper.updateMedicine(Medicine(
        id: medicine.id,
    name: medicine.name,

    TotalDose: (medicine.TotalDose),
    dose: medicine.dose,
    type: medicine.type,
    startDate: medicine.startDate,
    endDate: medicine.endDate,
    time: medicine.time,
    Remind: medicine.Remind,
    Repeat: medicine.Repeat,
    keys: widget.keys));
        print('Medicine dose updated ${medicine.TotalDose}');
      }
if(medicine.TotalDose == 0 )
{
   int id = DateTime.now().millisecondsSinceEpoch; 
    LocalNotification.scheduleNotificationsForPeriod(
    id: id,
    title: 'Medicine Reminder',
    body: 'Please Refill Your medicine',
    notificationTime: TimeOfDay.fromDateTime( DateTime.now().add(Duration(minutes: 1))),
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(minutes:  3)),
);

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
              'Don \'t Forget to take your medicine', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
            ),
          ],
        ),
      ),
    );
  }
}
