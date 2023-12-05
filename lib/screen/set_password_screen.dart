import 'package:copytaskmanager/screen/login_screen.dart';
import 'package:copytaskmanager/screen/signup_screen.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forgot_password_screen.dart';

class Set_Password_Screen extends StatefulWidget {
  const Set_Password_Screen({super.key});

  @override
  State<Set_Password_Screen> createState() => _Set_Password_ScreenState();
}

class _Set_Password_ScreenState extends State<Set_Password_Screen> {
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
                  Text("Set Password",
                  style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 10,),
                  Text("Minimum length password 8 character with Letter and number combination",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                  ),),
                  const SizedBox(height: 24,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      hintText: "Confirm Password"
                    )


                  ),
                  const SizedBox(height: 16,),

                  SizedBox(
                      width:double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                      }, child: Text('Confirm'))),

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
