import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task.dart';

// =========== TUGAS 3 ===========
class FirestoreService {
  CollectionReference<Map<String, dynamic>> get tasksRef {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw StateError('Pengguna harus login untuk mengakses tugas.');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('tasks');
  }

  Future<void> addTask(String title) async {
    await tasksRef.add({
      'title': title,
      'isDone': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Task>> getTasks() {
    return tasksRef
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Task.fromDoc(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> toggleDone(String id, bool value) async {
    await tasksRef.doc(id).update({'isDone': value});
  }

  // ============= NILAI TAMBAHAN =============
  Future<void> updateTaskTitle(String id, String title) async {
    await tasksRef.doc(id).update({'title': title});
  }
  // ============= NILAI TAMBAHAN END ==========

  Future<void> deleteTask(String id) async {
    await tasksRef.doc(id).delete();
  }
}

// =========== TUGAS 3 SELESAI ===========
