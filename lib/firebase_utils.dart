import 'package:app_to_do/model/my_user.dart';
import 'package:app_to_do/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static CollectionReference<Task> collectionTasks(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFireStore(snapshot.data()!)),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> writingTaskToFireStoreAfterChecked(
      Task task, String uId) {
    var taskCollectionRef = collectionTasks(uId);
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return collectionTasks(uId).doc(task.id).delete();
  }

  static Future<void> updateUser(Task task, String uId) {
    return FirebaseUtils.collectionTasks(uId).doc(task.id).update({
      'title': task.title = 'hello amr',
      'description': 'hello',
      'change': task.change = true,
    });
  }

  static Future<void> udateText(Task task, String uId) {
    return FirebaseUtils.collectionTasks(uId).doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': task.dateTime?.millisecondsSinceEpoch,
    });
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: ((snapshot, option) =>
                MyUser.fromFireStore(snapshot.data())),
            toFirestore: (user, _) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
