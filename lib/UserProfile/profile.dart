import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
    setState(() {
      name = user.firstname + ' ' + user.lastname;
      email = user.email;
      phone = user.phonenumber;
      imageBytes = base64Decode(user.ProfileImage);
    });
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
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, letterSpacing: 1.2, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          imageBytes != null
              ? CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent ,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                child: Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                    ),
                ),
              )
              : Placeholder(), // Display a placeholder if imageBytes is null
          details(data: 'Name', title: name),
          details(data: 'Email', title: email),
          details(data: 'Phone Number', title: phone),
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Update Profile'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 50, vertical: 2),
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
                style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text(
                '$data',
                style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
