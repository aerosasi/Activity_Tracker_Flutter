import 'package:flutter/cupertino.dart';
import 'package:timetracker/models/job.dart';
import 'package:timetracker/services/api_path.dart';
import 'package:timetracker/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> deleteJob(Job job);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  //to ensure only one object of firestore is created
  final _service = FirestoreService.instance;

  // this to get or edit the jobs
  @override
  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  // this is for getting the jobs to display in the jobs page
  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  // to delete the jobs on swiping
  @override
  Future<void> deleteJob(Job job) async => await _service.deleteData(
    path: APIPath.job(uid, job.id)
  );
}
