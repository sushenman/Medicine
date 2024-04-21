import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medicine_reminder/UserProfile/update_profile.dart';
import 'package:medicine_reminder/dbHelper/registerdbhelper.dart';

class Profile extends StatefulWidget {
  final String keys;
  const Profile({Key? key, required this.keys}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

String name = '';
String email = '';
String phone = '';
String phonenumber = '';
Uint8List? imageBytes;

class _ProfileState extends State<Profile> {
fetchUserProfile(String keys) async {
  final user = await RegisterDbhelper.fetchRegisterByKey(keys);
  if (user != null) {
    setState(() {
      name = user.firstname + ' ' + user.lastname;
      email = user.email;
      phone = user.phonenumber;
      imageBytes = base64Decode(user.ProfileImage);
    });
  } else {
    // Handle the case when user is not found
    // For example, show a message or navigate to a different screen
    print('User not found with key: $keys');
  }
}

  @override
  void initState() {
    fetchUserProfile(widget.keys);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(62, 177, 110, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        title: const Text(
          'Profile',
          style:
              TextStyle(color: Color.fromARGB(255, 0, 0, 0), letterSpacing: 1.2, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 200 ,
            color: Color.fromRGBO(62, 177, 110, 1),
            child: Column(
              children: [
                SizedBox(height: 40,)
,                imageBytes != null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          imageBytes!,
                          width: 130, // fixed width
                          height: 130, // fixed height
                          fit: BoxFit
                              .cover, // use cover to ensure the image fills the circular space
                        ),
                      ),
                    )
                  : Container(),
              ],
            ), 
          ),
          // Display a placeholder if imageBytes is null
          details(title: 'Name', data: name),
          details(title: 'Email', data: email),
          details(title: 'Phone Number', data: phone),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push( context, MaterialPageRoute(builder: ( BuildContext context ) => Update_Profile(keys: widget.keys ,) ) );
              },
              child: Text('Update Profile'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(62, 177, 110, 1)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          )
        ],
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
                '$title',
                style: TextStyle(
                  fontFamily: 'Lato',
                  letterSpacing: 1.2,
                    fontSize: 24,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '$data',
                style: TextStyle(
                   fontFamily: 'Lato',
                  letterSpacing: 1.2,
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
