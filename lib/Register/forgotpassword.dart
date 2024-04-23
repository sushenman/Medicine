import 'package:flutter/material.dart';
import 'package:medicine_reminder/dbHelper/registerdbhelper.dart';

import 'resetpass.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailConfirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(62, 177, 110, 0),
        title: const Text('Forgot Password', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: <Widget>[
              const Text('Enter your email to reset your password', style: TextStyle(fontSize: 18, fontFamily: 'Lato', letterSpacing: 1.2, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              TextField(
                controller: emailConfirm,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 158, 148, 1),
                    // minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                      // check if the email exists in database 
                      // if it does not exist, show error message
                      // if it exists, send password reset email

                      RegisterDbhelper.fetchRegisterByEmail(emailConfirm.text).then((value) {
                        if (value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email does not exist'),
                            ),
                          );
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => resetPassword(email: emailConfirm.text,) ) );
                        }
                      }); 

                      // Send password reset email
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => resetPassword() ) );
                  },

                  child: const Text('Check Email'),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate back to login screen
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
