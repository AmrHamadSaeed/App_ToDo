import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ListProvider extends ChangeNotifier {
  late Task task;

  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();

  void getTaskFromFireStore() async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.collectionTasks().get();
    //List<QueryDocumentSnapshot<Task>>  => List<Task>
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((task) {
      if (selectedDate.day == task.dateTime?.day &&
          selectedDate.month == task.dateTime?.month &&
          selectedDate.year == task.dateTime?.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });
    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    getTaskFromFireStore();
  }
}
