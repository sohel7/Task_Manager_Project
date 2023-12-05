import 'package:copytaskmanager/screen/pin_verification_screen.dart';
import 'package:copytaskmanager/screen/signup_screen.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class forgot_password_Screen extends StatefulWidget {
  const forgot_password_Screen({super.key});

  @override
  State<forgot_password_Screen> createState() => _forgot_password_ScreenState();
}

class _forgot_password_ScreenState extends State<forgot_password_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body_Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80,),
                  Text("Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 10,),
              Text("A 6 digit verification pin will send to your email address",style: TextStyle(
                color: Colors.grey,
                fontSize: 14
              ),),
                  const SizedBox(height: 24,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(height: 16,),

                  SizedBox(
                      width:double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Pin_verification_Screen()));
                      }, child: Icon(Icons.arrow_circle_right_outlined))),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have accout?",style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);


                      },
                          child: Text('Sign In',
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
    );
  }
}
