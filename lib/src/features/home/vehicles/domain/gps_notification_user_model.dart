import 'dart:convert';

class NotificationUserModel {
  List<NotificationUser>? docs;
  NotificationUserModel({
    required this.docs,
  });
  NotificationUserModel.unknown() : docs = null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': docs?.map((x) => x.toMap()).toList(),
    };
  }

  factory NotificationUserModel.fromMap(Map<String, dynamic> map) {
    return NotificationUserModel(
      docs: List<NotificationUser>.from(
        (map['docs'] as List).map<NotificationUser>(
          (x) => NotificationUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationUserModel.fromJson(String source) =>
      NotificationUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NotificationUser {
  String userId;
  String? name;
  String enrollmentId;
  NotificationUser({
    required this.userId,
    this.name,
    required this.enrollmentId,
  });

  String get displayText {
    if (name == null) {
      return enrollmentId;
    }
    return '${name!} ($enrollmentId)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'enrollmentId': enrollmentId,
    };
  }

  factory NotificationUser.fromMap(Map<String, dynamic> map) {
    return NotificationUser(
      userId: map['_id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      enrollmentId: map['enrollmentId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationUser.fromJson(String source) =>
      NotificationUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
