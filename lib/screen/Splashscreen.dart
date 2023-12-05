import 'package:copytaskmanager/auth_controller/auth_controller.dart';
import 'package:copytaskmanager/screen/login_screen.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_button_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  goToLogin() async {
    final bool isLoggedIn = await AuthController.checkAuthState();
    Future.delayed(const Duration(seconds: 2)).then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
      isLoggedIn?
      const mainBottomNav(): const LoginScreen()), (route) => false);

    });
  }

  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: body_Background(
        child:Center(
          child:SvgPicture.asset("assets/images/logo.svg",width: 120,),
        ),
      ),

    );
  }
}
