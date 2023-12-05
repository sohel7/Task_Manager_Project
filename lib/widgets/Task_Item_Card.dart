import 'package:copytaskmanager/data_network_caller/network_caller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_caller/Model/Task.dart';
import '../data_network_caller/Utility/urls.dart';

enum TaskStatus { New, Progress, Completed, Cancel }

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task, required this.onStatusChange, required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {

  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);

    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatusURL(widget.task.sId ?? "", status));

    if(response.isSuccess){
      widget.onStatusChange();
    }
    widget.showProgress(false);



  }


  Future<void> deleteTaskStatus(String status) async {
    widget.showProgress(true);

    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatusURL(widget.task.sId ?? "", status));

    if(response.isSuccess){
      widget.onStatusChange();
    }
    widget.showProgress(false);



  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              widget.task.description.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              "Date:${widget.task.createdDate.toString()}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: showUpdateStatusModal,
                        icon: Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> item = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Status"),
            content: Column(mainAxisSize: MainAxisSize.min, children: item),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }
}
