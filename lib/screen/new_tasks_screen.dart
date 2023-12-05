import 'package:copytaskmanager/data_network_caller/Model/TaskCount.dart';
import 'package:copytaskmanager/data_network_caller/Model/TaskSumaryCountModel.dart';
import 'package:copytaskmanager/data_network_caller/Model/task_list_model.dart';
import 'package:copytaskmanager/data_network_caller/Utility/urls.dart';
import 'package:copytaskmanager/data_network_caller/networkResponse.dart';
import 'package:copytaskmanager/data_network_caller/network_caller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/Profile_Samary_Card.dart';
import '../widgets/Samari_Card.dart';
import '../widgets/Task_Item_Card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSumaryInProgress = false;

  Task_List_Model taskListModel = Task_List_Model();
  TaskSumaryCountModel taskSumaryCountModelList = TaskSumaryCountModel();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      taskListModel = Task_List_Model.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskCountSumaryList() async {
    getTaskCountSumaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskSumaryCountModelList =
          TaskSumaryCountModel.fromJson(response.jsonResponse);
    }
    getTaskCountSumaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTaskCountSumaryList();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTaskScrenn()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileSamaryCard(),
            SizedBox(height:3),
            Visibility(
                visible: getTaskCountSumaryInProgress == false && (taskSumaryCountModelList.taskCountList!.isNotEmpty),
                replacement: Center(
                  child: LinearProgressIndicator(),
                ),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskSumaryCountModelList.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                      TaskCount taskCount = taskSumaryCountModelList.taskCountList![index];
                    return FittedBox(
                      child: Row(
                        children: [
                          Visibility(
                            child: SamaryCard(
                              count: taskCount.sum.toString(),
                              title: taskCount.sId.toString(),
                            ),
                          ),

                        ],
                      ),
                    );
                  }),
                )),
            Expanded(
                child: Visibility(
              visible: getNewTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: getNewTaskList,
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getNewTaskList();
                        },
                        showProgress: (inProgress){
                          getNewTaskInProgress = inProgress;
                          if(mounted){
                            setState(() {

                            });
                          }
                        },
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
