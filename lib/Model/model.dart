class Medicine {
  int? id;
  String name;
  int dose;
    int TotalDose;
  String type;
  DateTime startDate;
  DateTime endDate;
   DateTime time;
  int Remind;
  String Repeat;
  String keys;

  Medicine({
    this.id,
    required this.name,
    required this.dose,
    required this.TotalDose,  
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.Remind,
    required this.Repeat,
    required this.keys
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dose': dose,
      'type': type,
      'TotalDose': TotalDose,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'time': time.toIso8601String(),
      'Remind': Remind,
      'Repeat': Repeat,
      'keys': keys
    };
  }
factory Medicine.fromMap(Map<String, dynamic> map) {
  return Medicine(
    id: map['id'],
    name: map['name'] ?? '',
    dose: map['dose'] ?? 0, // Default to 0 if null
    type: map['type'] ?? '',
    TotalDose: map['TotalDose'] ?? 0, // Default to 0 if null
    startDate: map['startDate'] != null ? DateTime.parse(map['startDate']) : DateTime.now(),
    endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : DateTime.now(),
    time: map['time'] != null ? DateTime.parse(map['time']) : DateTime.now(),
    Remind: map['Remind'] ?? 0, // Default to 0 if null
    Repeat: map['Repeat'] ?? '',
    keys: map['keys'] ?? '',
  );
}

}
