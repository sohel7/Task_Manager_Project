import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_caller/Model/TaskSumaryCountModel.dart';
import '../data_network_caller/Model/task_list_model.dart';
import '../data_network_caller/Utility/urls.dart';
import '../data_network_caller/networkResponse.dart';
import '../data_network_caller/network_caller.dart';
import '../widgets/Completed_Item_Card.dart';
import '../widgets/Profile_Samary_Card.dart';
import '../widgets/Task_Item_Card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool getCompleted = false;
  bool getTaskCountSumaryInProgress = false;

  Task_List_Model taskListModel = Task_List_Model();
  TaskSumaryCountModel taskSumaryCountModelList = TaskSumaryCountModel();

  Future<void> getInCompletedTaskList() async {
    getCompleted = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompletedTask);
    if (response.isSuccess) {
      taskListModel = Task_List_Model.fromJson(response.jsonResponse);
    }
    getCompleted = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskCountSumaryList() async {
    getCompleted = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskSumaryCountModelList =
          TaskSumaryCountModel.fromJson(response.jsonResponse);
    }
    getCompleted = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getInCompletedTaskList();
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
                    visible: getCompleted == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: getInCompletedTaskList,
                      child: ListView.builder(
                          itemCount: taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return CompletedItemCard(
                              task: taskListModel.taskList![index],
                              onStatusChange: () {
                                getInCompletedTaskList();
                              },
                              showProgress: (inProgress){
                                getCompleted = inProgress;
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
