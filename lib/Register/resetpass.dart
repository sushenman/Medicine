import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Model/registermodel.dart';
import 'package:medicine_reminder/dbHelper/registerdbhelper.dart';

class resetPassword extends StatefulWidget {
  final String email;

  resetPassword({required this.email});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  String firstname = '';
  String lastname = '';
  String phoneNumber = '';
  String profileImage = '';
  String key = '';
  int? id = 0;
  Icon icon1 =  Icon(Icons.remove_red_eye);
  Icon icon2 =  Icon(Icons.remove_red_eye);
  bool obscureText = true;
  bool obscureText1 = true;

@override
void initState() {
  super.initState();
  // Initialize class_Name after accessing widget.keys
  _fetchRegisterByEmail();
}

Future<void> _fetchRegisterByEmail() async {
  try {
    RegisterModel? register = await RegisterDbhelper.fetchRegisterByEmail(widget.email);
    if (register != null) {
      setState(() {
        id = register.id;
        firstname = register.firstname;
        lastname = register.lastname;
        phoneNumber = register.phonenumber;
        profileImage = register.ProfileImage;
        key = register.key;
      });
      print('id: $id');
      print('firstname: $firstname');
      print('lastname: $lastname');
      print('phoneNumber: $phoneNumber');
      print('profileImage: $profileImage');
      print('key: $key');
    } else {
      print('No record found for email: ${widget.email}');
    }
  } catch (e) {
    print('Error fetching register: $e');
  }
}


  resetPass() {


   
     if(_password.text.isEmpty || _confirmpassword.text.isEmpty){
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: 'Password cannot be empty',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    }
    else if (_password.text.length < 8 ||
        !_password.text.contains(RegExp(r'[0-9]')) ||
        !_password.text.contains(RegExp(r'[a-z]')) ||
        !_password.text.contains(RegExp(r'[A-Z]')) ||
        !_password.text.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message:
              'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    } 
    else if (_password.text != _confirmpassword.text) {
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: 'Passwords do not match',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    } else {
      // Reset password
      RegisterDbhelper.updateRegisterByEmail(RegisterModel(
        id: id,
          firstname: firstname,
          lastname: lastname,
          ProfileImage: profileImage,
          email: widget.email,
          phonenumber: phoneNumber,
          password: _password.text,
          confirmpassword: _confirmpassword.text,
          key: key));
          //snakbar
      final snackBar = SnackBar(  
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
          title: 'Success',
          message: 'Password reset successfully',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(62, 177, 110, 0),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Enter your new password',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _password,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          obscureText = !obscureText;
                          if(obscureText){
                            icon1 = Icon(Icons.remove_red_eye);
                          }else{
                            icon1 = Icon(Icons.visibility_off);
                          }
                        });
                      }, icon: icon1 ) ,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmpassword,
                    obscureText: obscureText1,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          obscureText1 = !obscureText1;
                          if(obscureText1){
                            icon2 = Icon(Icons.remove_red_eye);
                          }else{
                            icon2 = Icon(Icons.visibility_off);
                          }
                        });
                      }, icon: icon2 ) ,
                      labelText: 'Confirm Password',
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
                        resetPass();
                      },
                      child: const Text('Reset Password'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                    },
                    child: const Text('Back to Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
