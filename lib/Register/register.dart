import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:medicine_reminder/Model/registermodel.dart';
import 'package:medicine_reminder/Register/login.dart';
import 'package:medicine_reminder/dbHelper/registerdbhelper.dart';
// import 'package:medicine_reminder/widgets/button.dart';
import 'package:medicine_reminder/widgets/textfield.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  String selectedImagePath = '';
  final ImagePicker _imagePicker = ImagePicker();
  String selectedImage ='';
  Icon icon1 = Icon(Icons.remove_red_eye);
  Icon icon2 = Icon(Icons.remove_red_eye);
  bool obscureText = true;
  bool obscureText2 = true;
  @override
  void initState() {
    // getRandomString(14);
    super.initState();
  }

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _phonenumber.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

registerUser() {
  if (_firstname.text.isEmpty ||
      _lastname.text.isEmpty ||
      _email.text.isEmpty ||
      _phonenumber.text.isEmpty ||
      _password.text.isEmpty ||
      _confirmpassword.text.isEmpty) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: 'All fields are required',
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    return;
  } 
  else if (!_email.text.contains('@')) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: 'Invalid email format',
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    return;
  } 
else if (!RegExp(r'^[0-9]+$').hasMatch(_phonenumber.text)) {
  final snackBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    content: AwesomeSnackbarContent(
      title: 'Error',
      message: 'Phone number must contain only digits',
      contentType: ContentType.warning,
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
  return;
}


  
  else if (_phonenumber.text.length != 10) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: 'Phone number must be 10 digits',
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
        message: 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character',
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
  }
 

  
  else {
       RegisterModel register = RegisterModel(
      firstname: _firstname.text,
      lastname: _lastname.text,
      ProfileImage: selectedImagePath,
      email: _email.text,
      phonenumber: _phonenumber.text,
      password: _password.text,
      confirmpassword: _confirmpassword.text,
      key: getRandomString(14),
    );
    //check if email already exists 
    RegisterDbhelper.fetchRegisterByEmail(_email.text).then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'Email already exists',
            contentType: ContentType.warning,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        // Proceed with registration
        RegisterDbhelper.insertRegister(register).then((value) {
          final snackBar = SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: 'Registration successful',
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          });
        });
      }
    });


  }
}

  String getRandomString(int length) {
    var random = Random.secure();
    var values = List<int>.generate(length, (index) => random.nextInt(33) + 89);
    return String.fromCharCodes(values);
  }

Future<void> _pickImage() async {
  final XFile? pickedFile =
      await _imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    final encodedImage = base64Encode(bytes);

    setState(() {
      selectedImagePath = encodedImage;
      selectedImage = pickedFile.path;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Color.fromARGB(0, 0, 0, 0),
                  child: selectedImagePath.isNotEmpty
                      ? Builder(builder: (context) {
                          return ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: CircleBorder(),
                            ),
                            child: Image.file(
                              File(selectedImage),
                              fit: BoxFit.contain,
                            ),
                          );
                        })
                      : Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            onPressed: () => _pickImage(),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Profile Picture',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2),
              ),
              SizedBox(
                height: 30,
              ),
              MyInputTextField(
                label: 'First Name',
                controller: _firstname,
              ),
              SizedBox(
                height: 30,
              ),
              MyInputTextField(
                label: 'Last Name',
                controller: _lastname,
              ),
              SizedBox(
                height: 30,
              ),
              MyInputTextField(
                label: "Email",
                controller: _email,
              ),
              SizedBox(
                height: 30,
              ),
              MyInputTextField(
                label: "Phone Number",
                controller: _phonenumber,
              ),
              SizedBox(
                height: 30,
              ),
            TextFormField(
              obscureText: obscureText,
              controller: _password,
              decoration: InputDecoration(
                 contentPadding: EdgeInsets.only(left: 10),
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                    
                ),
                suffixIcon: IconButton(
                  icon: icon1,
                  onPressed: () {
                    setState(() {
                      icon1 = icon1.icon == Icons.remove_red_eye
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.remove_red_eye);
                      // _passwordVisible = !_passwordVisible;
                      obscureText = !obscureText;
                      
                    });
                  },
                ),

                
              ),
            ),
             
              SizedBox(
                height: 30,
              ),
             TextFormField(
              obscureText: obscureText2,
              
              controller: _confirmpassword,
              decoration: InputDecoration(
                 contentPadding: EdgeInsets.only(left: 10),
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                    
                ),
                suffixIcon: IconButton(
                  icon: icon2,
                  onPressed: () {
                    setState(() {
                      icon2 = icon2.icon == Icons.remove_red_eye
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.remove_red_eye);
                      // _passwordVisible = !_passwordVisible;
                      obscureText2 = !obscureText2;
                      
                    });
                  },
                ),

                
              ),
            ),
             
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => registerUser(),
             
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 158, 148, 1),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
