// ignore_for_file: file_names, non_constant_identifier_names

class TaskState {
  int? id;
  int user_id;
  int inprogress;
  int done;
  TaskState({
    required this.user_id,
    required this.inprogress,
    required this.done,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'inProgrss': inprogress,
      'done': done,
    };
  }

  factory TaskState.fromJson(Map<String, dynamic> map) {
    return TaskState(
      user_id: map['user_id'] ?? 0,
      inprogress: map['inProgrss'] ?? 0,
      done: map['done'] ?? 0,
    );
  }
}
