import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_caller/Model/TaskSumaryCountModel.dart';
import '../data_network_caller/Model/task_list_model.dart';
import '../data_network_caller/Utility/urls.dart';
import '../data_network_caller/networkResponse.dart';
import '../data_network_caller/network_caller.dart';
import '../widgets/Cancle_Item_Card.dart';
import '../widgets/Profile_Samary_Card.dart';
import '../widgets/Task_Item_Card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {


  bool getCancle = false;
  bool getTaskCountSumaryInProgress = false;

  Task_List_Model taskListModel = Task_List_Model();
  TaskSumaryCountModel taskSumaryCountModelList = TaskSumaryCountModel();

  Future<void> getInCancleTaskList() async {
    getCancle = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancelledTask);
    if (response.isSuccess) {
      taskListModel = Task_List_Model.fromJson(response.jsonResponse);
    }
    getCancle = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskCountSumaryList() async {
    getCancle = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskSumaryCountModelList =
          TaskSumaryCountModel.fromJson(response.jsonResponse);
    }
    getCancle = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getInCancleTaskList();
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
                  visible: getCancle == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getInCancleTaskList,
                    child: ListView.builder(
                        itemCount: taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return CancleItemCard(
                            task: taskListModel.taskList![index],
                            onStatusChange: () {
                              getInCancleTaskList();
                            },
                            showProgress: (inProgress){
                              getCancle = inProgress;
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
