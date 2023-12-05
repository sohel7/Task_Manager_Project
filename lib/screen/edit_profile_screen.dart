


import 'package:copytaskmanager/auth_controller/auth_controller.dart';
import 'package:copytaskmanager/data_network_caller/Model/UserModel.dart';
import 'package:copytaskmanager/data_network_caller/networkResponse.dart';
import 'package:copytaskmanager/data_network_caller/network_caller.dart';
import 'package:copytaskmanager/widgets/Profile_Samary_Card.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:copytaskmanager/widgets/snakbar_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data_network_caller/Utility/urls.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;
  XFile? photo;



  Future<void> profileUpdate()async {
    if (_formKey.currentState!.validate()) {
    _updateProfileInProgress = true;

    if (mounted) {
      setState(() {

      });
    }

    String ? photoInBase64;

    Map<String, dynamic> inputData = {
      "email": _emailController.text.trim().toString(),
      "firstName": _firstNameController.text.trim().toString(),
      "lastName": _lastNameController.text.trim().toString(),
      "mobile": _mobileController.text.trim().toString(),
    };

    if (_passwordController.text.isNotEmpty) {
      inputData['password'] = _passwordController.text;
    }

    // try {
    //   if (photo != null) {
    //     List<int> imagesBytes = await photo!.readAsBytes();
    //     String photoInBase64 = base64Encode(imagesBytes);
    //
    //     // Remove the first 23 characters
    //     if (photoInBase64.length > 23) {
    //       photoInBase64 = photoInBase64.substring(23);
    //     } else {
    //
    //       print('please cheack');
    //     }
    //
    //     inputData['photo'] = photoInBase64;
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }

    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.profileUpdate, body: inputData);
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {

      });
    }

    if (response.isSuccess) {

      AuthController.updateUserInformation(UserModel(
        email: _emailController.text.trim().toString(),
        firstName: _firstNameController.text.trim().toString(),
        lastName: _lastNameController.text.trim().toString(),
        mobile: _mobileController.text.trim().toString(),
          // photo:  photoInBase64?? AuthController.user?.photo
      ));

      if (mounted) {
        showSnakMessage(context, "Success",);
      }
    } else {
      if (mounted) {
        showSnakMessage(context, "Not Success", true);
      }
    }
  }

  }


  @override
  void initState() {
    _emailController.text = AuthController.user?.email ?? '';
    _firstNameController.text = AuthController.user?.firstName ?? '';
    _lastNameController.text = AuthController.user?.lastName ?? '';
    _mobileController.text = AuthController.user?.mobile ?? '';
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSamaryCard(
              enableOnTap: false,
            ),
            Expanded(child: body_Background(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 32,),
                          Text('Update Profile',style: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(height: 16,),
                          Photo_Picker_filed(),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _emailController,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter valid Email!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'E-mail'

                            ),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _firstNameController,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter First Name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'First Name'

                            ),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _lastNameController,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter Last Name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Last Name'

                            ),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _mobileController,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter valid Mobile!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Mobile'

                            ),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                hintText: 'Password(Optional)'

                            ),
                          ),
                          SizedBox(height: 16,),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _updateProfileInProgress == false,
                              replacement: Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: profileUpdate,
                                child: Icon(Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  )
              ),
            )
            )
          ],
        ),
      ),
    );
  }

  Container Photo_Picker_filed() {
    return Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex:1,
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      )
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Photo',style: TextStyle(
                                      color: Colors.white,
                                    ),),

                                                              ),
                                )),
                            Expanded(
                              flex:3,
                                child: InkWell(
                                  onTap: (){},
                                  child: Container(
                                    child: Visibility(
                                        visible: photo == null,
                                        replacement:Text(photo ?.name?? '') ,
                                        child: const Text('Select a photo')),
                                  ),
                                )
                            ),
                          ],

                        ),
                      );
  }
}
