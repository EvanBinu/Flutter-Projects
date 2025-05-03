import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(height: 48.0),
              RoundedTextField(
                hintText: 'Enter your email',
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 8.0),
              RoundedTextField(
                hintText: 'Enter your password',
                isPassword: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    if (email.isEmpty || password.isEmpty) {
                      throw FirebaseAuthException(
                        code: 'empty-fields',
                        message: 'Email and password cannot be empty!',
                      );
                    }

                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email.trim(),
                      password: password.trim(),
                    );

                    if (newUser.user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = '';

                    if (e.code == 'email-already-in-use') {
                      errorMessage =
                          'This email is already registered. Try logging in.';
                    } else if (e.code == 'weak-password') {
                      errorMessage =
                          'Password is too weak. Please choose a stronger password.';
                    } else if (e.code == 'invalid-email') {
                      errorMessage = 'The email address entered is invalid.';
                    } else if (e.code == 'empty-fields') {
                      errorMessage = 'Please enter both email and password.';
                    } else {
                      errorMessage = 'Registration failed. Please try again.';
                    }

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(errorMessage)));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An unknown error occurred.')),
                    );
                  } finally {
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
