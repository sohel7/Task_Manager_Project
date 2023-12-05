import 'dart:convert';
import 'dart:typed_data';

import 'package:copytaskmanager/auth_controller/auth_controller.dart';
import 'package:copytaskmanager/screen/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/login_screen.dart';

class ProfileSamaryCard extends StatefulWidget {
  const ProfileSamaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSamaryCard> createState() => _ProfileSamaryCardState();
}

class _ProfileSamaryCardState extends State<ProfileSamaryCard> {

  // Uint8List imageBytes =  Base64Decoder().convert(AuthController.user?.photo?? '');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if(widget.enableOnTap){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
        }
      },
      leading: CircleAvatar(
        // child: AuthController.user?.photo == null?
        // Icon(Icons.person):ClipRRect(
        //   borderRadius: BorderRadius.circular(40),
        //   child: Image.memory(imageBytes,fit: BoxFit.cover,),
        // ),
        child: Icon(Icons.flutter_dash),
      ),
      title: Text(
      AuthController.user?.firstName ?? '',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700
        ),),
      subtitle: Text(
        AuthController.user?.email ?? '',

        style: TextStyle(
            color: Colors.white
        ),),
      trailing: IconButton(
        onPressed: ()async{
          await AuthController.clearAuthData();
          if(mounted){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()), (route) => false);
          }
        },
        icon: Icon(Icons.logout),
      ),
      tileColor: Colors.green,
    );
  }

}
