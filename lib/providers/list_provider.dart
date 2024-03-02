import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/model/task.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ListProvider extends ChangeNotifier {
  late Task task;
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();
  bool change = true;
  Color color = MyTheme.greenColor;

  void getTaskFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.collectionTasks(uId).get();
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

  void changeSelectedDate(DateTime newSelectedDate, String uId) {
    selectedDate = newSelectedDate;
    getTaskFromFireStore(uId);
  }

  updateThemeClr() {
    // task.isDone = change;
    notifyListeners();
  }

  void changeTheme(Color colorNew) {
    if (color == colorNew) {
      return;
    }
    color = colorNew;
    notifyListeners();
  }

  bool isDarkMode() {
    return change == task.change;
  }

  void ischange(Color newColor) {
    if (task.change == true) {
      color == newColor;
    }
    color = newColor;
    notifyListeners();
  }
// static Future<void> updateUser(Task task ,bool name) {
//   return  FirebaseUtils.collectionTasks()
//       .doc(task.id)
//       .update({'title': task.title = 'hello amr', 'description':'hello', 'change':name,
//   });
// }
}
