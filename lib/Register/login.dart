import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:medicine_reminder/Register/forgotpassword.dart';
import 'package:medicine_reminder/Register/register.dart';
import 'package:medicine_reminder/bottomNav.dart';


import '../dbHelper/registerdbhelper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController emailConfirm = TextEditingController();

bool obscureText = true;

Icon icon = Icon(Icons.remove_red_eye);

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    // authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 26, 26, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      'WELCOME',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RubikDoodleShadow',
                          letterSpacing: 1.2),
                    ),
                  ),
                ],
              ),
             
            ),
       
            Positioned(
              bottom: 0,
              right: 0,
              top: 220,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  //  color: Color.fromARGB(255, 35, 233, 255),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                      ),
                      Container(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 35,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                ),
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    suffixIcon: IconButton(
                                      icon: icon,
                                      onPressed: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                          if (obscureText) {
                                            icon = Icon(Icons.remove_red_eye);
                                          } else {
                                            icon = Icon(Icons.visibility_off);
                                          }
                                        });
                                      },
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ForgotPassword();
                          }));
                        
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'New to account? ',
                                    style: TextStyle(
                                        fontSize: 16, letterSpacing: 1),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return Register();
                                      }));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        letterSpacing: 1,
                                        color: Color.fromRGBO(0, 158, 148, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            String email = _email.text;
                            String password = _password.text;

                            if (email.isEmpty || password.isEmpty) {
                              final snackBar = SnackBar(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                behavior: SnackBarBehavior.floating,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Please fill all fields',
                                  contentType: ContentType.warning,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            } else {
                              // Check the database for the user
                              Map<String, dynamic> user = await RegisterDbhelper
                                  .fetchRegisterByEmailAndPassword(
                                      email, password);
                              if (user.isNotEmpty) {
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  behavior: SnackBarBehavior.floating,
                                  content: AwesomeSnackbarContent(
                                    title: 'Success',
                                    message: 'Login successful',
                                    contentType: ContentType.success,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => 
                                      BottomNavBar(keys: user['key']), // Pass the key to HomePage
                                    ),
                                  );
                                });
                              } else {
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  behavior: SnackBarBehavior.floating,
                                  content: AwesomeSnackbarContent(
                                    title: 'Error',
                                    message: 'Invalid email or password',
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              }
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 158, 148, 1),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
