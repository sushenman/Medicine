import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:medicine_reminder/Model/registermodel.dart';
import 'package:medicine_reminder/Register/forgotpassword.dart';
import 'package:medicine_reminder/Register/register.dart';
import 'package:medicine_reminder/bottomNav.dart';
import 'package:medicine_reminder/homeppage.dart';

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

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
//create a path from bottom
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 1.1,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.4, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // throw UnimplementedError();
    return false;
  }
}

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
              // child: Image.asset('assets/images/bookslogos.png', fit: BoxFit.cover,),
            ),
            // Positioned(
            //   // top:0,
            //   bottom: 200,
            //   left: 100,
            //   child: Center(
            //     child: Container(
            //       height: MediaQuery.of(context).size.height ,
            //       child: Image.network('https://i.pinimg.com/originals/c7/b9/aa/c7b9aae8e7106049a72bf626f6a6bd96.png', height: 80,width: 200 , fit: BoxFit.contain,),
            //     ),
            //   ),
            // ),
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
                              // Center(
                              //   child: Image.asset(
                              //     'assets/images/login.png',
                              //     height: 100,
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Text(
                              //   'Login',
                              //   style: TextStyle(
                              //       fontSize: 20, fontWeight: FontWeight.bold),
                              // ),
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
                                    //                                   border: OutlineInputBorder(
                                    //                                       borderRadius: BorderRadius.circular(10),
                                    // ),
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
                                    //                                   border: OutlineInputBorder(
                                    //                                       borderRadius: BorderRadius.circular(10),
                                    // ),
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
                          //                     showDialog(
                          //                         context: context,
                          //                         builder: (BuildContext context) {
                          //                           return AlertDialog(
                          //                             title: Text(
                          //                               'Forgot Password',
                          //                               style: TextStyle(
                          //                                   fontSize: 16, letterSpacing: 1.2),
                          //                             ),
                          //                             content: Container(
                          //                               height: 120,
                          //                               child: Column(
                          //                                 children: [
                          //                                   Text(
                          //                                       'Enter your email address to reset your password'),
                          //                                   SizedBox(
                          //                                     height: 20,
                          //                                   ),
                          //                                   Container(
                          //                                     decoration: BoxDecoration(
                          //                                       color: const Color.fromARGB(
                          //                                           255, 255, 255, 255),
                          //                                       borderRadius:
                          //                                           BorderRadius.circular(10),
                          //                                     ),
                          //                                     child: TextFormField(
                          //                                       controller: emailConfirm,
                          //                                       obscureText: false,
                          //                                       decoration: InputDecoration(
                          //                                         contentPadding:
                          //                                             EdgeInsets.only(left: 20),
                          //                                         hintText: 'Email',
                          //                                         hintStyle: TextStyle(
                          //                                           color: Colors.grey,
                          //                                         ),
                          //                                         border: OutlineInputBorder(
                          //                                           borderRadius:
                          //                                               BorderRadius.circular(10),
                          //                                         ),
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                             actions: [
                          //                               ElevatedButton(
                          //                                 onPressed: () {
                          //                                   // Reset the password by searching the email and changing the password in the database
                          //                                   String email = emailConfirm.text;
                          // if(email == RegisterDbhelper.fetchRegisterByEmail(email)  )
                          // {
                          //   //create a dialog box to enter new password
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         title: Text('Reset Password'),
                          //         content: Container(
                          //           height: 200,
                          //           child: Column(
                          //             children: [
                          //               Text('Enter your new password'),
                          //               SizedBox(height: 20),
                          //               Container(
                          //                 decoration: BoxDecoration(
                          //                   color: const Color.fromARGB(255, 255, 255, 255),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 child: TextFormField(
                          //                   obscureText: true,
                          //                   decoration: InputDecoration(
                          //                     contentPadding: EdgeInsets.only(left: 20),
                          //                     hintText: 'Password',
                          //                     hintStyle: TextStyle(
                          //                       color: Colors.grey,
                          //                     ),
                          //                     border: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(10),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               SizedBox(height: 20),
                          //               Container(
                          //                 decoration: BoxDecoration(
                          //                   color: const Color.fromARGB(255, 255, 255, 255),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 child: TextFormField(
                          //                   obscureText: true,
                          //                   decoration: InputDecoration(
                          //                     contentPadding: EdgeInsets.only(left: 20),
                          //                     hintText: 'Confirm Password',
                          //                     hintStyle: TextStyle(
                          //                       color: Colors.grey,
                          //                     ),
                          //                     border: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(10),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         actions: [
                          //           ElevatedButton(
                          //             onPressed: () {
                          //               // Update the password in the database
                          //               String password = _password.text;
                          //               String confirmPassword = emailConfirm.text;
                          //               if (password == confirmPassword) {
                          //                 // Update the password/ in the database by comparing the email
                          //                 RegisterDbhelper.updateRegisterPassword(email, password);
                          //                 Navigator.pop(context);
                          //               } else {
                          //                 final snackBar = SnackBar(
                          //                   elevation: 0,
                          //                   backgroundColor: Colors.transparent,
                          //                   behavior: SnackBarBehavior.floating,
                          //                   content: AwesomeSnackbarContent(
                          //                     title: 'Error',
                          //                     message: 'Passwords do not match',
                          //                     contentType: ContentType.warning,
                          //                   ),
                          //                 );
                          //                 ScaffoldMessenger.of(context)
                          //                   ..hideCurrentSnackBar()
                          //                   ..showSnackBar(snackBar);
                          //               }
                          //             },
                          //             child: Text('Reset Password'),
                          //             style: ElevatedButton.styleFrom(
                          //               primary: Color.fromRGBO(0, 158, 148, 1),
                          //               minimumSize: Size(MediaQuery.of(context).size.width, 50),
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       );
                          //     },
                          //   );
                          // } else {
                          //   final snackBar = SnackBar(
                          //     elevation: 0,
                          //     backgroundColor: Colors.transparent,
                          //     behavior: SnackBarBehavior.floating,
                          //     content: AwesomeSnackbarContent(
                          //       title: 'Error',
                          //       message: 'Email not found',
                          //       contentType: ContentType.warning,
                          //     ),
                          //   );
                          //   ScaffoldMessenger.of(context)
                          //     ..hideCurrentSnackBar()
                          //     ..showSnackBar(snackBar);
                          // }

                          //                                 },
                          //                                 child: Text('Reset Password'),
                          //                                 style: ElevatedButton.styleFrom(
                          //                                     primary:
                          //                                         Color.fromRGBO(0, 158, 148, 1),
                          //                                     minimumSize: Size(
                          //                                         MediaQuery.of(context).size.width,
                          //                                         50),
                          //                                     shape: RoundedRectangleBorder(
                          //                                       borderRadius:
                          //                                           BorderRadius.circular(10),
                          //                                     )),
                          //                               )
                          //                             ],
                          //                           );
                          //                         });
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
                                      builder: (context) => BottomNavBar(
                                          keys: user[
                                              'key']), // Pass the key to HomePage
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
