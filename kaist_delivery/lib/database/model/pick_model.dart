class PickModel {
  final int? id; // SQLite AUTOINCREMENT 필드
  final String name;

  PickModel({
    this.id, // DB INSERT 시 null 일 수 있음.
    required this.name,
  });

  // DB INSERT/UPDATE 시 사용될 Map 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // DB SELECT 결과를 PickModel로 변환
  factory PickModel.fromMap(Map<String, dynamic> map) {
    return PickModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
