import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/widgets/textfield.dart';
import 'package:water_bottle/water_bottle.dart';
import 'package:medicine_reminder/Model/model.dart'; // Import your MedicineModel class
import 'package:medicine_reminder/dbHelper/dbhelper.dart'; // Import your DatabaseHelper class
import 'package:intl/intl.dart';

// import 'widgets/button.dart';

class Remain_Dose extends StatefulWidget {
  int id;
  String keys;
  String name;
  int totaldose;
  int dose;
  String type;
  DateTime time;
  DateTime startDate;
  DateTime endDate;
  int remind;
  String repeat;

  Remain_Dose(
      {required this.id,
      required this.keys,
      required this.name,
      required this.totaldose,
      required this.dose,
      required this.type,
      required this.time,
      required this.startDate,
      required this.endDate,
      required this.remind,
      required this.repeat});

  @override
  State<Remain_Dose> createState() => _Remain_DoseState();
}

class _Remain_DoseState extends State<Remain_Dose> {
  final bottleRef = GlobalKey<SphericalBottleState>();

  bool isVisisble = false;
  bool isVisisble1 = true;
  bool isVisibletime = true;
  bool isVisibletime1 = false;
  bool isVisibleTotalDose = true;
  bool isVisibleTotalDose1 = false;
  late int totalDose;
  TextEditingController totalDoseController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime getTime = DateTime.now();
  DateTime getDate = DateTime.now();

  @override
  void initState() {
    totalDose = widget.totaldose;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medicine details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisisble = !isVisisble;
                  isVisisble1 = !isVisisble1;
                });
              },
              child: Column(
                children: [
                  Visibility(
                    visible: isVisisble1,
                    child: Container(
                      child: details(title: 'Medicine Name', data: widget.name),
                    ),
                  ),
                  Visibility(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Medicine Name',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 20),
                              MyInputTextField(
                                  label: widget.name,
                                  controller: nameController),
                              SizedBox(height: 20),
                              updateButton(
                                label: 'Update ',
                                onTap: () {
                                  setState(() {
                                    if (nameController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Please enter a name'),
                                        ),
                                      );
                                    } else {
                                      DatabaseHelper.updateMedicine(Medicine(
                                        id: widget.id,
                                        keys: widget.keys,
                                        name: nameController.text,
                                        dose: widget.dose,
                                        TotalDose: widget.totaldose,
                                        type: widget.type,
                                        startDate: widget.startDate,
                                        endDate: widget.endDate,
                                        time: widget.time,
                                        Remind: widget.remind,
                                        Repeat: widget.repeat,
                                      ));
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return Remain_Dose(
                                          id: widget.id,
                                          keys: widget.keys,
                                          name: nameController.text,
                                          dose: widget.dose,
                                          totaldose: widget.totaldose,
                                          type: widget.type,
                                          startDate: widget.startDate,
                                          endDate: widget.endDate,
                                          time: widget.time,
                                          remind: widget.remind,
                                          repeat: widget.repeat,
                                        );
                                      }));
                                      isVisisble = !isVisisble;
                                      isVisisble1 = !isVisisble1;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    visible: isVisisble,
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  isVisibleTotalDose = !isVisibleTotalDose;
                  isVisibleTotalDose1 = !isVisibleTotalDose1;
                });
              },
              child: Column(
                children: [
                  Visibility(
                    visible: isVisibleTotalDose,
                    child: Container(
                      child: details(
                          title: 'Total Dose', data: totalDose.toString()),
                    ),
                  ),
                  Visibility(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Total Dose',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 20),
                              MyInputTextField(
                                  label: widget.totaldose.toString(),
                                  controller: totalDoseController),
                              SizedBox(height: 20),
                              updateButton(
                                label: 'Update ',
                                onTap: () {
                                  setState(() {
                                    if (totalDoseController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please enter a total dose'),
                                        ),
                                      );
                                    } else if (!RegExp(r'^[0-9]+$')
                                        .hasMatch(totalDoseController.text)) {
                                      final snackBar = SnackBar(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        behavior: SnackBarBehavior.floating,
                                        content: AwesomeSnackbarContent(
                                          title: 'Error',
                                          message:
                                              'Dose must contain only digits',
                                          contentType: ContentType.warning,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                      return;
                                    } else {
                                      DatabaseHelper.updateMedicine(Medicine(
                                        id: widget.id,
                                        keys: widget.keys,
                                        name: widget.name,
                                        dose: widget.dose,
                                        TotalDose:
                                            int.parse(totalDoseController.text),
                                        type: widget.type,
                                        startDate: widget.startDate,
                                        endDate: widget.endDate,
                                        time: widget.time,
                                        Remind: widget.remind,
                                        Repeat: widget.repeat,
                                      ));
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return Remain_Dose(
                                          id: widget.id,
                                          keys: widget.keys,
                                          name: widget.name,
                                          dose: widget.dose,
                                          totaldose: int.parse(
                                              totalDoseController.text),
                                          type: widget.type,
                                          startDate: widget.startDate,
                                          endDate: widget.endDate,
                                          time: widget.time,
                                          remind: widget.remind,
                                          repeat: widget.repeat,
                                        );
                                      }));
                                    }

                                    isVisibleTotalDose = !isVisibleTotalDose;
                                    isVisibleTotalDose1 = !isVisibleTotalDose1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    visible: isVisibleTotalDose1,
                  ),
                ],
              ),
            ),
            // Container(
            //   child: details(
            //       title: 'Dose Remaining',
            //       data: ' ${widget.totaldose - widget.dose}'),
            // ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisibletime = !isVisibletime;
                  isVisibletime1 = !isVisibletime1;
                });
              },
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisibletime = !isVisibletime;
                        isVisibletime1 = !isVisibletime1;
                      });
                    },
                    child: Column(
                      children: [
                        Visibility(
                          visible: isVisibletime,
                          child: Container(
                            child: details(
                              title: 'Time',
                              data: DateFormat('hh:mm a').format(widget.time),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: isVisibletime1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        'Time',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 20),
                                      MyInputTextField(
                                        label: DateFormat.jm().format(getTime),
                                        customwi: IconButton(
                                          onPressed: () async {
                                            TimeOfDay? pickerTime =
                                                await showTimePicker(
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
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            color:
                                                Color.fromRGBO(62, 177, 110, 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      updateButton(
                                        label: 'Update ',
                                        onTap: () {
                                          setState(() {
                                            DatabaseHelper.updateMedicine(
                                                Medicine(
                                              id: widget.id,
                                              keys: widget.keys,
                                              name: widget.name,
                                              dose: widget.dose,
                                              TotalDose: widget.totaldose,
                                              type: widget.type,
                                              startDate: widget.startDate,
                                              endDate: widget.endDate,
                                              time: getDate,
                                              Remind: widget.remind,
                                              Repeat: widget.repeat,
                                            ));
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                              return Remain_Dose(
                                                id: widget.id,
                                                keys: widget.keys,
                                                name: widget.name,
                                                dose: widget.dose,
                                                totaldose: widget.totaldose,
                                                type: widget.type,
                                                startDate: widget.startDate,
                                                endDate: widget.endDate,
                                                time: getDate,
                                                remind: widget.remind,
                                                repeat: widget.repeat,
                                              );
                                            }));
                                            isVisibletime = !isVisibletime;
                                            isVisibletime1 = !isVisibletime1;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class details extends StatelessWidget {
  final String title;
  final String data;

  const details({Key? key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 232, 232, 232),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                '$title',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text(
                '$data',
                style: TextStyle(
                    fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class updateButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  updateButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 1, 2, 0),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
