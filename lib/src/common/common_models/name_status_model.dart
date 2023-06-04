import 'dart:convert';

class NameStatusModel {
  final String name;
  bool status;

  NameStatusModel({
    required this.name,
    this.status = false,
  });

  NameStatusModel copyWith({
    String? name,
    bool? status,
  }) {
    return NameStatusModel(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
    };
  }

  factory NameStatusModel.fromMap(Map<String, dynamic> map) {
    return NameStatusModel(
      name: map['name'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NameStatusModel.fromJson(String source) => NameStatusModel.fromMap(json.decode(source));

  @override
  String toString() => 'NameStatusModel(name: $name, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NameStatusModel && other.name == name && other.status == status;
  }

  @override
  int get hashCode => name.hashCode ^ status.hashCode;
}
