import 'package:flutter/material.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart'; // Import your DatabaseHelper class
import '../Model/model.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late List<Medicine> endedMedications = [];

  @override
  void initState() {
    super.initState();
    // Fetch medications with end date in the past
    DatabaseHelper.getMedicationsEnded().then((medications) {
      setState(() {
        endedMedications = medications;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Medicine History',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(children: [
          if (endedMedications.isEmpty)
            ListTile(
              title: Text('No medications ended yet'),
            ),
          for (var medication in endedMedications)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 170, 170, 170).withOpacity(0.8),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Color.fromRGBO(62, 177, 110, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  medication.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 24,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dosage: ${medication.TotalDose}, ',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 20,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'End date: ${DateFormat('dd/MM/yyyy').format(medication.endDate)}, ',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 20,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ]));
  }
}
