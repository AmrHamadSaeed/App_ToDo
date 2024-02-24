import 'package:app_to_do/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static CollectionReference<Task> collectionTasks() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFireStore(snapshot.data()!)),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> writingTaskToFireStoreAfterChecked(Task task) {
    var taskCollectionRef = collectionTasks();
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return collectionTasks().doc(task.id).delete();
  }

  static Future<void> updateUser(Task task) {
    return FirebaseUtils.collectionTasks().doc(task.id).update({
      'title': task.title = 'hello amr',
      'description': 'hello',
      'change': task.change = true,
    });
  }

  static Future<void> udateText(Task task) {
    return FirebaseUtils.collectionTasks().doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': task.dateTime,
    });
  }

  static Future<void> updateNotifications(Task task) async {
    await FirebaseFirestore.instance
        .collection('userNotifications')
        .doc(task.id)
        .update({
      'change': task.change == true,
      'title': task.title = 'amrrrrr',
      'description': task.description = 'noname',
    });
  }
}
