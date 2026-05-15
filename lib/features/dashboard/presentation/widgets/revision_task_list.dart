import 'package:flutter/material.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/revision_task_card.dart';

/// A list of revision tasks.
class RevisionTaskList extends StatelessWidget {
  final List<RevisionTask> tasks;
  final ValueChanged<RevisionTask> onTaskCompleted;
  final ValueChanged<RevisionTask> onTaskDeleted;

  const RevisionTaskList({
    super.key,
    required this.tasks,
    required this.onTaskCompleted,
    required this.onTaskDeleted,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text('No revision tasks scheduled.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return RevisionTaskCard(
          task: task,
          onComplete: () => onTaskCompleted(task),
          onDelete: () => onTaskDeleted(task),
        );
      },
    );
  }
}