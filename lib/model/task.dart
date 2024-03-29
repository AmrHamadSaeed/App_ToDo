class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? change;

  // bool? isDone;

  Task({
    this.id = '',
    required this.dateTime,
    required this.description,
    required this.title,
    this.change = false,
  });

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
    id: data['id'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          change: data['change'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'change': change,
    };
  }
}
