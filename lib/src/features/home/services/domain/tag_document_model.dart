class TagDocumentModel {
  final String name;
  final String url;
  TagDocumentModel({
    required this.name,
    required this.url,
  });

  TagDocumentModel copyWith({
    String? name,
    String? url,
  }) {
    return TagDocumentModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TagDocumentModel && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
