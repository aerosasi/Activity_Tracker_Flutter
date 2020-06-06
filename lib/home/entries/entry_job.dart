import 'package:timetracker/models/entry.dart';
import 'package:timetracker/models/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
