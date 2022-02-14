// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_app/conf.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/ui/pages/home_page.dart';
import 'package:to_app/ui/size_config.dart';
import 'package:to_app/ui/widgets/snackbar.dart';
import 'package:email_auth/email_auth.dart';

// ignore: constant_identifier_names
enum AuthMode { SignUp, Login }

class Login extends StatefulWidget {
  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthMode _authMode = AuthMode.SignUp;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showpassword = false;
  bool submitValid = false;

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _otpcontroller = TextEditingController();

  //Initialize the package EmailAuth
  var emailAuth = EmailAuth(
    sessionName: 'Sample session',
  );

  /// a void funtion to send the OTP to the user
  sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  /// a void function to verify if the Data provided is true
  bool verify() {
    return (emailAuth.validateOtp(
        recipientMail: _emailController.text,
        userOtp: _otpcontroller.value.text));
  }

  void _submit() {
    if (_authMode == AuthMode.SignUp) {
      if (_formKey.currentState!.validate()) {
        Tasks()
            .register(_passwordController.text, _emailController.text,
                _nameController.text)
            .then((response) {
          if (response == 'failed') {
            Snackbar().snackbar('Register', 'Register Failed Lost Connection');
          } else {
            var res = json.decode(response);
            var message = res['message'];
            if (res['status'] == 0) {
              Snackbar().snackbar('Register', 'Failed Register  ');
            } else {
              Snackbar().snackbar('Register', message);
              _switchAuthMode();
            }
          }
        });
      }
    } else {
      if (_formKey.currentState!.validate()) {
        Tasks()
            .login(_passwordController.text, _emailController.text)
            .then((response) {
          if (response == 'failed') {
            print('login');
            Snackbar().snackbar('Login', 'Login Failed Lost Connection');
          } else {
            var res = json.decode(response);
            var message = res['message'];
            if (res['status'] == 0) {
              Snackbar().snackbar('Login', res['message']);
            } else {
              if (res['access_token'] != null) {
                GetStorage().write('token', res['access_token']);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (builder) => const HomePage()));
              } else {
                Snackbar().snackbar('Login', 'Failed Login');
              }
            }
          }
        });
      }
    }
  }

  _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/login.jpg'), fit: BoxFit.cover)),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.kLightYellow),
            height: _authMode == AuthMode.SignUp ? 450 : 240,
            constraints: BoxConstraints(
                minHeight: _authMode == AuthMode.SignUp ? 320 : 230),
            width: deviceSize.width * 0.75,
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (_authMode == AuthMode.SignUp)
                      TextFormField(
                        enabled: _authMode == AuthMode.SignUp,
                        decoration: const InputDecoration(labelText: 'Name'),
                        controller: _nameController,
                        validator: _authMode == AuthMode.SignUp
                            ? (value) {
                                if (value == null) {
                                  return 'Please Enter your Name';
                                }
                                return null;
                              }
                            : null,
                      ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Enter Your Email!';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid Email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // = value!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpassword = !showpassword;
                                });
                              },
                              icon: Icon(
                                showpassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ))),
                      obscureText: !showpassword,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password!';
                        }
                        if (value.length < 5) {
                          return 'Password is Too Short!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        //_authData['password'] = value!;
                      },
                    ),
                    if (_authMode == AuthMode.SignUp)
                      TextFormField(
                        enabled: _authMode == AuthMode.SignUp,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showpassword = !showpassword;
                                  });
                                },
                                icon: Icon(
                                  showpassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ))),
                        obscureText: !showpassword,
                        validator: _authMode == AuthMode.SignUp
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords Do Not Match!';
                                }
                                return null;
                              }
                            : null,
                      ),
                    if (_authMode == AuthMode.SignUp)
                      Stack(
                        alignment: const Alignment(1.0, 1.0),
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Enter Code',
                            ),
                            controller: _otpcontroller,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_emailController.text.isEmpty) {
                                  Snackbar().snackbar(
                                      'Empty Email', 'Please Enter Your Email');
                                } else {
                                  sendOtp();
                                }
                              },
                              child: const Text('Send Code'),
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.kBlue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(horizontal: 5)),
                              )),
                        ],
                      ),
                      const SizedBox(height: 5,),
                    ElevatedButton(
                        child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                        ),
                        onPressed: () {
                          if (_authMode == AuthMode.SignUp) {
                            if (_emailController.text.isNotEmpty) {
                              if (verify()) {
                                _submit();
                              } else {
                                Snackbar()
                                    .snackbar('Login', 'Incorrect Code !!');
                              }
                            } else {
                              Snackbar().snackbar(
                                  'Empty Email', 'Please Enter Your Email');
                            }
                          } else
                            _submit();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.kBlue),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0)),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .button!
                                      .color)),
                        )),
                    TextButton(
                      onPressed: () {
                        _switchAuthMode();
                      },
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD',
                          style: const TextStyle(color: AppColors.kBlue)),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 4)),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(color: Theme.of(context).primaryColor)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
