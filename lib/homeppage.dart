import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/Model/model.dart';
import 'package:medicine_reminder/UserProfile/profile.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart';
import 'package:medicine_reminder/addMeds.dart';
import 'package:medicine_reminder/details.dart';
import 'package:medicine_reminder/local_notification.dart';
import 'package:medicine_reminder/orderHistory.dart';
import 'package:medicine_reminder/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {

final String keys;
HomePage({ required this.keys});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Medicine> medicines = [];
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    print(widget.keys);
    fetchMedicines(selectedDate);
    super.initState();
  }

  Future<void> fetchMedicines(DateTime selectedDate) async {
    List<Medicine> allMedicines = await DatabaseHelper.fetchMedicines();
    setState(() {
      // Filter medicines based on start and end dates
      //verify the keys and then only display the medicines
      medicines = allMedicines .where((medicine) => medicine.keys == widget.keys).toList();
      //now filter the medicines based on start date and end date 
      if (selectedDate != null) { 
        medicines = medicines
            .where((medicine) =>
                (medicine.startDate.isBefore(selectedDate) ||
                    medicine.startDate.isAtSameMomentAs(selectedDate)) &&
                (medicine.endDate.isAfter(selectedDate) ||
                    medicine.endDate.isAtSameMomentAs(selectedDate)))
            .toList();
      } else {
        medicines = medicines;
      }
      
      // medicines = allMedicines
      //     .where((medicine) =>
      //         (medicine.startDate.isBefore(selectedDate) ||
      //             medicine.startDate.isAtSameMomentAs(selectedDate)) &&
      //         (medicine.endDate.isAfter(selectedDate) ||
      //             medicine.endDate.isAtSameMomentAs(selectedDate)))
      //     .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Reminder',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (BuildContext context) => OrderHistory()));
        //         // Local_Notification().scheduledNotification();
        //       },
        //       icon: Icon(
        //         Icons.history,
        //         color: Colors.black,
        //       )),
        //       IconButton(onPressed: (){
        //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Profile(keys: widget.keys ) ) );
        //       }, icon: Icon(Icons.person, color: Colors.black,))
        // ],
     
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Times New Roman'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Today',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Times New Roman'),
                        ),
                      ],
                    ),
                  ),
                  // Buttons(
                  //   label: "Add Medicine",
                  //   onTap: () {
                  //     print('he');
                  //     // Local_Notification.showScheduledNotification(
                  //     //     scheduledNotificationDateTime:
                  //     //         DateTime.now().add(Duration(seconds: 1)),
                  //     //     id: 0,
                  //     //     title: 'repeating title',
                  //     //     body: 'repeating body',
                  //     //     payload: 'repeating payload');

                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AddMedsPage(keys: widget.keys ,)));
                  //   },
                  // )
               
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Color(0xFF4e5ae8),
                selectedTextColor: Colors.white,
                dateTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
                dayTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
                monthTextStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
                onDateChange: (date) {
                  print(medicines.length);
                  setState(() {
                    selectedDate = date;
                  });
                  fetchMedicines(
                      selectedDate); // Fetch medicines for the selected date
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (BuildContext context, int index) {
                  Medicine medicine = medicines[index];
                  return GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Remain_Dose( keys: widget.keys , name: medicine.name , dose: medicine.dose, totaldose:  medicine.TotalDose , type: medicine.type, startDate: medicine.startDate, endDate: medicine.endDate, time: medicine.time),)),
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
                                  color: Color.fromARGB(255, 255, 174, 0),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.grey.withOpacity(0.5),
                                    //   spreadRadius: 1,
                                    //   blurRadius: 5,
                                    //   offset: const Offset(0, 3),
                                    // ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
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
                                            height: 10,
                                          ),
                                          Text(
                                            'Dose: ${medicine.dose}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Times New Roman',color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Time: ${DateFormat.jm().format(medicine.time)}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Times New Roman',color: Colors.white),
                                          ),
                                        
                                        ],
                                      ),
                                    )
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
          ],
        ),
      ),
    );
  }
}
