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
Future<bool> _validateInputs() async {
  if (firstController.text.isEmpty ||
      lastController.text.isEmpty ||
      emailController.text.isEmpty ||
      phoneController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All fields are required'),
      ),
    );
    return false;
  } else if (!emailController.text.contains('@')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid email format'),
      ),
    );
    return false;
  } else if (!RegExp(r'^[0-9]+$').hasMatch(phoneController.text)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number must be digits only'),
      ),
    );
    return false;
  } else if (phoneController.text.length != 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number must be 10 digits'),
      ),
    );
    return false;
  }

  // Check if the email is already registered
  final existingUser = await RegisterDbhelper.fetchRegisterByEmail(emailController.text);
  if (existingUser != null) {
    // Email already exists
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email already registered'),
      ),
    );
    return false;
  } else {
    // Email doesn't exist, proceed with the update process
    _updateProfile();
    return true;
  }
}

void _updateProfile() {
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
      key: widget.keys,
    ),
  );
  final snackBar = SnackBar(
    content: Text('Profile updated successfully'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                color: Color.fromRGBO(62, 177, 110, 1),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(0, 255, 32, 32),
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {},
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
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 233, 232, 232),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'First Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 7),
                            TextFormField(
                              controller: firstController,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Last Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 7),
                            TextFormField(
                              controller: lastController,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 7),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 7),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Container(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _validateInputs();
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(62, 177, 110, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
