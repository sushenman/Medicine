import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/bottomNav.dart';
import 'package:medicine_reminder/dbHelper/registerdbhelper.dart';
import 'package:medicine_reminder/widgets/textfield.dart';

import '../Model/registermodel.dart';

class Update_Profile extends StatefulWidget {
  String keys;
  Update_Profile({required this.keys});

  @override
  State<Update_Profile> createState() => _Update_ProfileState();
}

class _Update_ProfileState extends State<Update_Profile> {
  int? id = 0;
  String name = '';
  String email = '';
  String phonenumber = '';
  String password ='';
  String image ='';
  String confirmpassword = '';


  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

fetchUserProfile(String keys) async {
  final user = await RegisterDbhelper.fetchRegisterByKey(keys);
  setState(() {
    if (user != null) {
      firstController.text = user.firstname;
      lastController.text = user.lastname;
      emailController.text = user.email;
      phoneController.text = user.phonenumber;
      image = user.ProfileImage;
      password = user.password;
      confirmpassword = user.confirmpassword;
      print(user.ProfileImage);
      id  = user.id;
    } else {
      // Handle the case where user is null
    }
  });
}

  @override
  void initState() {
    fetchUserProfile(widget.keys);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.red),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(0, 255, 32, 32),
                  elevation: 0.0,
                  // title: Text('Welcome'),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => personalInfo()), (route) => false);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 233, 232, 232),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'First Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  controller: firstController,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Last Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  controller: lastController,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Email',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2)),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Phone Number',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2)),
                                SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        RegisterDbhelper.updateRegister(
                                            RegisterModel(
                                                firstname: firstController.text,
                                                lastname: lastController.text,
                                                email: emailController.text,
                                                phonenumber: phoneController.text,
                                                password: password,
                                                confirmpassword: confirmpassword,
                                                ProfileImage: image,
                                                id: id,
                                                key: widget.keys));
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar(keys: widget.keys )  ) );
                                      },
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20), // <-- Radius
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
