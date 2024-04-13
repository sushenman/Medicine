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
      body: SingleChildScrollView(
        child: Column(
          children: endedMedications.map((medicine) {
            return ListTile(
              title: Text(medicine.name),
            

// Inside the build method of _OrderHistoryState class
subtitle: Text('End Date: ${DateFormat('yyyy-MM-dd').format(medicine.endDate)}'),

              // You can customize how each medication is displayed
            );
          }).toList(),
        ),
      ),
    );
  }
}
