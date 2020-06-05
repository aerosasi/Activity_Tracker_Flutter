import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //to ensure only one object of firestore is created
  FirestoreService._();

  static final instance = FirestoreService._();

  // to add or edit the jobs both handled in this method
  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = Firestore.instance.document(path);
    await reference.setData(data);
  }

  // this gets the data from the firebase
  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => builder(snapshot.data, snapshot.documentID),
        )
        .toList());
  }

  // this is to delete the the data in the firebase
  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    print('delete: $path');
    await reference.delete();
  }
}
