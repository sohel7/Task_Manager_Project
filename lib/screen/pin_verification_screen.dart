import 'package:copytaskmanager/screen/set_password_screen.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_screen.dart';

class Pin_verification_Screen extends StatefulWidget {
  const Pin_verification_Screen({super.key});

  @override
  State<Pin_verification_Screen> createState() => _Pin_verification_ScreenState();
}

class _Pin_verification_ScreenState extends State<Pin_verification_Screen> {
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
                  Text("Pin Verification",
                  style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 10,),
              Text("A 6 digit verification pin will send to your email address",style: TextStyle(
                color: Colors.grey,
                fontSize: 14
              ),),
                  const SizedBox(height: 24,),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.green,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,

                    ),

                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    }, appContext: context,
                  ),
                  const SizedBox(height: 16,),

                  SizedBox(
                      width:double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Set_Password_Screen()));
                      }, child: Text('Verify'))),
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
