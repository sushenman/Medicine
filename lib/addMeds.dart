import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/Model/model.dart';
import 'package:medicine_reminder/bottomNav.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart';
import 'package:medicine_reminder/homeppage.dart';
import 'package:medicine_reminder/local_notification.dart';
import 'widgets/textfield.dart';

class AddMedsPage extends StatefulWidget {
String keys;
AddMedsPage({ required this.keys});

  @override
  State<AddMedsPage> createState() => _AddMedsPageState();
}

DateTime getDate = DateTime.now();
DateTime getTime = DateTime.now();

DateTime endDate = DateTime.now();

List<int> RemindList = [5, 10, 15, 20];
int selectedReminder = RemindList[0];
List<String> RepeatList = ['Daily', 'Weekly'];
String selectedRepeat = RepeatList[0];
List<String> medsType = ['Tablet', 'Syrup', 'Capsule', 'Injection', 'Drops'];
String selectedType = medsType[0];
Map<String, List<String>> doseTypeMap = {
  'Tablet': ['Tabs', ],
  'Syrup': ['ml'],
  'Capsule': ['mg'],
  'Injection': ['unit', 'ml'],
  'Drops': ['drop'],
};
String selectedDoseType = doseTypeMap[selectedType]![0];

class _AddMedsPageState extends State<AddMedsPage> {
  late TextEditingController name;
  late TextEditingController dose;
  late TextEditingController type;
  late TextEditingController totaldose; 

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    dose = TextEditingController();
    type = TextEditingController();
    totaldose = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    dose.dispose();
    type.dispose();
    super.dispose();
  }

void addMedicine() {
  if (name.text.isEmpty || dose.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill all the fields'),
      ),
    );
    return;
  }
Local_Notification.showScheduledNotification(
  id: 0, // You can use the ID returned from the database insertion
  title: 'Medicine Reminder',
  body: 'It\'s time to take ${name.text}',
  scheduledNotificationDateTime: getTime, // Schedule at the chosen time
);


  Medicine medicine = Medicine(
    name: name.text,
    dose: int.parse(dose.text),
    type: type.text,
    TotalDose: int.parse(totaldose.text),
    startDate: getDate,
    endDate: endDate,
    time: getTime,
    Remind: selectedReminder,
    Repeat: selectedRepeat,
    keys: widget.keys,
  );

  DatabaseHelper.insertMedicine(medicine).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medicine added successfully'),
      ),
    );

    // Schedule the notification
    

    name.clear();
    dose.clear();
    type.clear();
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to add medicine'),
      ),
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Medicine',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Text(
                    'Name of the medicine',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  label: 'Medicine Name',
                  controller: name,
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  customwi: DropdownButton(
                    padding: const EdgeInsets.only(left: 10),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    value: selectedType,
                    items: medsType.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value as String;
                        selectedDoseType = doseTypeMap[selectedType]![0];
                      });
                    },
                  ),
                  label: 'Type',
                  controller: type,
                ),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'Total Dosage (${selectedDoseType})',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  label: 'Total Dose',
                  controller: totaldose,
                ),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'Dose (per intake)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  label: 'Dose',
                  controller: dose,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'Start Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyInputTextField(
                            label: DateFormat.yMd().format(getDate),
                            customwi: IconButton(
                              onPressed: () async {
                                DateTime? pickerDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );
                                if (pickerDate != null) {
                                  setState(() {
                                    getDate = pickerDate;
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'End Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyInputTextField(
                            label: DateFormat.yMd().format(endDate),
                            customwi: IconButton(
                              onPressed: () async {
                                DateTime? endpickerDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );
                                if (endpickerDate != null) {
                                  setState(() {
                                    endDate = endpickerDate;
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Text(
                    'Select Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  label: DateFormat.jm().format(getTime),
                  customwi: IconButton(
                    onPressed: () async {
                      TimeOfDay? pickerTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickerTime != null) {
                        setState(() {
                          getTime = DateTime(
                            getDate.year,
                            getDate.month,
                            getDate.day,
                            pickerTime.hour,
                            pickerTime.minute,
                          );
                        });
                      }
                    },
                    icon: const Icon(Icons.access_time),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Text(
                    'Remind (in mins)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  label: '$selectedReminder minutes early',
                  customwi: DropdownButton(
                    padding: const EdgeInsets.only(left: 10),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    value: selectedReminder,
                    items: RemindList.map((int value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedReminder = value as int;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Text(
                    'Repeat',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyInputTextField(
                  label: '$selectedRepeat',
                  customwi: DropdownButton(
                    padding: const EdgeInsets.only(left: 10),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    value: selectedRepeat,
                    items: RepeatList.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRepeat = value as String;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      addMedicine();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar(keys: 'ahd')),
                      );
                    },
                    child: const Text('Add Medicine'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF4e5ae8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
