import 'package:axlerate/src/features/home/services/domain/tag_document_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tagStatusIconProvider = StateProvider.autoDispose<Widget?>((ref) {
  return const SizedBox();
});

final tagDocumentsProvider = StateNotifierProvider<TagDocumentsNotifier, List<TagDocumentModel>>(
  (ref) {
    return TagDocumentsNotifier();
  },
);

class TagDocumentsNotifier extends StateNotifier<List<TagDocumentModel>> {
  TagDocumentsNotifier() : super([]);

  void addItem(TagDocumentModel doc) {
    if (state.length < 2) {
      state.add(doc);
    }
  }
}
