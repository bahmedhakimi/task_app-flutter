// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:to_app/conf.dart';
import 'package:to_app/models/task.dart';
import 'package:to_app/models/taskState.dart';
import 'package:to_app/ui/widgets/snackbar.dart';

class TaskController extends GetxController {
  RxList<Task> tasklist = <Task>[].obs;
  RxList<TaskState> taskstatelist = <TaskState>[].obs;
  RxString name = ''.obs;

  getTasks() async {
    Tasks().getdata().then((response) {
      if (response == 'failed') {
        Snackbar().snackbar('Fetch Data', 'Lost Connection');
      } else {
        var list = json.decode(response);
        var mylist = list['body'];
        tasklist.clear();
        mylist.forEach((element) {
          tasklist.add(Task.fromJson(element));
        });
      }
    });
  }

  getTasksState() async {
    Tasks().get_task_state().then((response) {
      if (response == 'failed') {
        Snackbar().snackbar('Fetch Task State', 'Lost Connection');
      } else {
        var list = json.decode(response);
        var mylist = list['body'];

        if (mylist == null) {
          Tasks().insert_state().then((value) {
            if (value == 'failed') {
              Snackbar().snackbar('Fetch Task State', 'Lost Connection');
            } else {
              print('stat task');
              getTasksState();
            }
          });
        }
        taskstatelist.clear();
        taskstatelist.add(TaskState.fromJson(mylist));
      }
    });
  }

  deletTasks(int id,iscomplited) async {
    await Tasks().delet_Tasks(id,iscomplited);

    getTasks();
    getTasksState();
  }

  task_complited(int id) async {
    await Tasks().task_complited(id);
    getTasks();
    getTasksState();
  }

  Future logout() async {
    await Tasks().logout();
  }

  get_user() {
    Tasks().get_user().then((response) {
      if (response == 'failed') {
        Snackbar().snackbar('Fetch User Data', 'Lost Connection');
      } else {
        var list = json.decode(response);
        name.value = list['body'];
      }
    });
  }

  insert_date(data) {
    try {
      Tasks().insert_data(data).then((responce) {
        if (responce == 'failed') {
          Snackbar().snackbar('Insert New Task', 'Lost Connection');
        } else {
          var list = json.decode(responce);
          var message = list['message'];
          if (list['status'] == 1) {
            Snackbar().snackbar('Insert New Task', message);
          }
        }
      });
    } catch (e) {
      print(e.toString());
      Snackbar().snackbar('Insert New Task', e.toString());
    }
  }
}
