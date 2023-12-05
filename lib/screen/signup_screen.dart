import 'package:copytaskmanager/data_network_caller/Utility/urls.dart';
import 'package:copytaskmanager/data_network_caller/network_caller.dart';
import 'package:copytaskmanager/screen/login_screen.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:copytaskmanager/widgets/snakbar_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_caller/networkResponse.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool _signUpInProgress=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body_Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Join With Us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid Email!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _firstNameController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid FirstName!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "First Name",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _lastNameController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid LastName!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Last Name",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _mobileController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid Mobile!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Mobile",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter valid Password!";
                          }
                          if (value!.length < 6) {
                            return "Enter password more than 6 letter";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Password")),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _signUpInProgress == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              onPressed:_signup,
                              child: Icon(Icons.arrow_circle_right_outlined)),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have accout?",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signup()async {
    if (_formKey.currentState!.validate()) {
      _signUpInProgress = true;
      if(mounted){
        setState(() {
        });
      }
      final NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration,body: {
        "email":_emailController.text.trim(),
        "firstName":_firstNameController.text.trim(),
        "lastName":_lastNameController.text.trim(),
        "mobile":_mobileController.text.trim(),
        "password":_passwordController.text.toString(),

      });
      _signUpInProgress = false;
      if(mounted){
        setState(() {
        });
      }
      if (response.isSuccess) {
        _clearTextField();
        if (mounted) {
          showSnakMessage(context, "registration success");
        }else{

          if(mounted){
            showSnakMessage(context, "registration failed",true);
          }

        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
  }

  void _clearTextField(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }
}


