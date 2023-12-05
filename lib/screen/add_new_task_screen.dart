import 'package:copytaskmanager/data_network_caller/Utility/urls.dart';
import 'package:copytaskmanager/data_network_caller/networkResponse.dart';
import 'package:copytaskmanager/data_network_caller/network_caller.dart';
import 'package:copytaskmanager/widgets/Profile_Samary_Card.dart';
import 'package:copytaskmanager/widgets/body_background.dart';
import 'package:copytaskmanager/widgets/snakbar_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTaskScrenn extends StatefulWidget {
  const AddNewTaskScrenn({super.key});

  @override
  State<AddNewTaskScrenn> createState() => _AddNewTaskScrennState();
}

class _AddNewTaskScrennState extends State<AddNewTaskScrenn> {

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createTaskInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSamaryCard(),
            Expanded(
                child: body_Background(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text('Add New Task',style: Theme.of(context).textTheme.titleLarge,),
                            SizedBox(height: 16,),
                            TextFormField(
                              controller: _subjectController,
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return "Enter Subject";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'subject'

                              ),
                            ),
                            SizedBox(height: 8,),
                            TextFormField(
                              maxLines: 8,
                              controller: _descriptionController,
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return "Enter Description";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'description'

                              ),
                            ),
                            SizedBox(height: 16,),
                            SizedBox(
                              width: double.infinity,
                              child: Visibility(
                                visible: _createTaskInProgress == false,
                                replacement: Center(child: CircularProgressIndicator(),),
                                child: ElevatedButton(
                                  onPressed: createTask,
                                  child: Icon(Icons.arrow_circle_right_outlined),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                )

            )
          ],
        ),
      ),
    );
  }
  Future<void> createTask()async{
    if(_formKey.currentState!.validate()){

      _createTaskInProgress = true;
      if(mounted){
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title":_subjectController.text.toString(),
        "description":_descriptionController.text.toString(),
        "status":"New"
      });
      _createTaskInProgress = false;
      if(mounted){
        setState(() {});
      }
      if(response.isSuccess){
        _subjectController.clear();
        _descriptionController.clear();
        if(mounted){
          showSnakMessage(context, "Task Added Success",);
        }
      }else{
        if(mounted){
          showSnakMessage(context, "can't add task! Please try again!",true);
        }
      }

    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
