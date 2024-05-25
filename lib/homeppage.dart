import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/Model/model.dart';
import 'package:medicine_reminder/Register/login.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart';
import 'package:medicine_reminder/details.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  final String keys;
  HomePage({required this.keys});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Medicine> medicines = [];
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    print(widget.keys);
    fetchMedicines(selectedDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMedicines(selectedDate);
  }

  Future<void> fetchMedicines(DateTime selectedDate) async {
    List<Medicine> allMedicines = await DatabaseHelper.fetchMedicines();
    setState(() {
      medicines = allMedicines
          .where((medicine) =>
              medicine.keys == widget.keys &&
              (medicine.startDate.isBefore(selectedDate) ||
                  medicine.startDate.isAtSameMomentAs(selectedDate)) &&
              (medicine.endDate.isAfter(selectedDate) ||
                  medicine.endDate.isAtSameMomentAs(selectedDate)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          'Medi-Alert',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        backgroundColor: Color.fromRGBO(62, 177, 110, 1),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 0, 96, 8).withOpacity(0.8),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Color.fromRGBO(62, 177, 110, 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 37, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 24,
                              letterSpacing: 1.2,
                              fontFamily: 'Lato',
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Today',
                          style: TextStyle(
                              fontSize: 22,
                              letterSpacing: 1.5,
                              fontFamily: 'Lato',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Color.fromRGBO(62, 177, 110, 1),
                selectedTextColor: Color.fromARGB(255, 255, 255, 255),
                dateTextStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                dayTextStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                monthTextStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                  fetchMedicines(selectedDate); // Fetch medicines for the selected date
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: medicines.length,
                  itemBuilder: (BuildContext context, int index) {
                    Medicine medicine = medicines[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Remain_Dose(
                              id: medicine.id!,
                              keys: widget.keys,
                              name: medicine.name,
                              dose: medicine.dose,
                              totaldose: medicine.TotalDose,
                              type: medicine.type,
                              startDate: medicine.startDate,
                              endDate: medicine.endDate,
                              time: medicine.time,
                              remind: medicine.Remind,
                              repeat: medicine.Repeat,
                            ),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(62, 177, 110, 1),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 170, 170, 170)
                                            .withOpacity(0.8),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 20,
                                            top: 10,
                                            bottom: 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              medicine.name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Times New Roman',
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Dose: ${medicine.dose}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Lato',
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Time: ${DateFormat.jm().format(medicine.time)}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Lato',
                                                      color: Colors.white),
                                                ),
                                                Container(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        DatabaseHelper
                                                            .deleteMedicine(
                                                                medicine); // Pass the entire Medicine object
                                                        medicines.remove(
                                                            medicine); // Remove the medicine from the list
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
