import 'dart:math';

import 'package:copytaskmanager/auth_controller/auth_controller.dart';
import 'package:copytaskmanager/data_network_caller/Model/UserModel.dart';
import 'package:copytaskmanager/data_network_caller/Utility/urls.dart';
import 'package:copytaskmanager/data_network_caller/networkResponse.dart';
import 'package:copytaskmanager/data_network_caller/network_caller.dart';
import 'package:copytaskmanager/screen/signup_screen.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:copytaskmanager/widgets/snakbar_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forgot_password_screen.dart';
import 'main_button_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  bool _logInProgress = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body_Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80,),
                    Text("Get Started with",
                    style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 24,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter valid Email!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter valid Password!";
                          }
                          if (value!.length < 6) {
                            return "Enter password more than 6 letter";
                          }
                          return null;
                        },
                      decoration:  InputDecoration(
                        hintText: "Password"
                      )
                
                
                    ),
                    const SizedBox(height: 16,),
                
                    SizedBox(
                        width:double.infinity,
                        child: Visibility(
                          visible: _logInProgress == false,
                          replacement: Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: login,
                              child: Icon(Icons.arrow_circle_right_outlined)),
                        )),
                    const SizedBox(height: 30,),
                    Center(child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>forgot_password_Screen()));
                
                    },
                        child: Text('Forgot Password',
                          style: TextStyle(
                            color: Colors.grey,fontSize: 16
                          ),
                        ))),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an accout?",style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                    ),),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        },
                            child: Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.green,fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
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
  
  Future<void> login()async{

    if(!_formkey.currentState!.validate()){
      return ;
    }
      _logInProgress = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response = await NetworkCaller().postRequest(
          Urls.login, body: {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      },isLogin: true);
      _logInProgress = false;
      if (mounted) {
        setState(() {

        });
      }

      if (response.isSuccess) {
        await AuthController.saveUserInformation(response.jsonResponse['token'], UserModel.fromJson(response.jsonResponse['data']));
        if (mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const mainBottomNav()));
        }
      } else {
        if (response.statusCode == 401) {
          if (mounted) {
            showSnakMessage(context, "Please Check Email and Password!");
          }
        } else {
          if (mounted) {
            showSnakMessage(context, "Login Faild! Please try again!");
          }
        }
      }




      
    
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
