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

  static Future<void> saveTaskToFireStore(Task task) {
    var taskCollectionRef = collectionTasks();
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return collectionTasks().doc(task.id).delete();
  }
}
