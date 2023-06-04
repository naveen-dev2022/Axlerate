import 'dart:developer';

import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listPaymentPageNotifierProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((
  ref,
) {
  return PageNotifierNew();
});

final enablePaymnetDocCountProvider = StateProvider<int>((ref) {
  return 1;
});

final enablePaymentDocsNotifierProvider = StateNotifierProvider<EnablePaymnetDocs, List<int>>((ref) {
  return EnablePaymnetDocs();
});

class EnablePaymnetDocs extends StateNotifier<List<int>> {
  EnablePaymnetDocs() : super([1]);

  void addAnother() {
    state.add(state.last + 1);
    log(state.toString());
  }
}

class DocListItemModel {
  final TextEditingController docName;
  final TextEditingController docUrl;
  final String docFieldTitle;
  final String docFieldHint;
  final String docTitle;
  final String docHint;

  DocListItemModel({
    required this.docName,
    required this.docUrl,
    this.docFieldTitle = 'Document',
    this.docFieldHint = 'Select Document',
    this.docTitle = 'Document Name',
    this.docHint = 'Upload File',
  });
}

final List<TextEditingController> controllersName = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];
final List<TextEditingController> controllersUrl = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];

final enableDocsNotifierProvider = StateNotifierProvider<EnableDocsStorage, List<DocListItemModel>>((ref) {
  return EnableDocsStorage();
});

class EnableDocsStorage extends StateNotifier<List<DocListItemModel>> {
  EnableDocsStorage() : super([]);

  void addAnotherDoc() {
    state.add(DocListItemModel(
      docName: controllersName[state.length],
      docUrl: controllersUrl[state.length],
      docFieldTitle: 'Document ${state.length + 1}',
      docTitle: 'Document ${state.length + 1}',
    ));
  }
}
