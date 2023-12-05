import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_caller/Model/TaskSumaryCountModel.dart';
import '../data_network_caller/Model/task_list_model.dart';
import '../data_network_caller/Utility/urls.dart';
import '../data_network_caller/networkResponse.dart';
import '../data_network_caller/network_caller.dart';
import '../widgets/In_Progress_Item_Card.dart';
import '../widgets/Profile_Samary_Card.dart';
import '../widgets/Samari_Card.dart';
import '../widgets/Task_Item_Card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool getInProgress = false;
  bool getTaskCountSumaryInProgress = false;

  Task_List_Model taskListModel = Task_List_Model();
  TaskSumaryCountModel taskSumaryCountModelList = TaskSumaryCountModel();

  Future<void> getInProgressTaskList() async {
    getInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getInProgressTask);
    if (response.isSuccess) {
      taskListModel = Task_List_Model.fromJson(response.jsonResponse);
    }
    getInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskCountSumaryList() async {
    getInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskSumaryCountModelList =
          TaskSumaryCountModel.fromJson(response.jsonResponse);
    }
    getInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getInProgressTaskList();
    getTaskCountSumaryList();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSamaryCard(),
            Expanded(
                child: Visibility(
                  visible: getInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                    child: RefreshIndicator(
                      onRefresh:getInProgressTaskList ,
                      child: ListView.builder(
                          itemCount: taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InProgressItemCard(
                              task: taskListModel.taskList![index],
                              onStatusChange: () {
                                getInProgressTaskList();
                              },
                              showProgress: (inProgress){
                                getInProgress = inProgress;
                                if(mounted){
                                  setState(() {

                                  });
                                }
                              },
                            );
                          }
                          ),
                    ),
                  ),

            )
          ],
        ),
      ),
    );
  }
}
