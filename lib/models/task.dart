class Task {
  int? id;
  String title;
  String note;
  String isCompleted;
  String date;
  String startTime;
  String color;
  String remind;
  String repeat;
 

  Task({
    this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.color,
    required this.remind,
    required this.repeat,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
      
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      note: map['note'] ?? '',
      isCompleted: map['isCompleted'] ?? '',
      date: map['date'] ?? '',
      startTime: map['startTime'] ?? '',
      color: map['color'] ?? '',
      remind: map['remind'] ?? '',
      repeat: map['repeat'] ?? '',
     
    );
  }
}
