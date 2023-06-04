import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageNotifierProvider = StateNotifierProvider.autoDispose<PageNotifier, List<int>>((ref) {
  return PageNotifier();
});

final ppiTxnpageNotifierNewProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((
  ref,
) {
  return PageNotifierNew();
});

final tagTxnpageNotifierNewProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((ref) {
  return PageNotifierNew();
});

final lqTagTxnpageNotifierNewProvider = StateNotifierProvider<PageNotifierNew, PaginatorModel>((ref) {
  return PageNotifierNew();
});

class PaginatorModel {
  List<int> pages;
  int pageIndex;
  PaginatorModel({
    required this.pages,
    required this.pageIndex,
  });
}

class PageNotifierNew extends StateNotifier<PaginatorModel> {
  PageNotifierNew() : super(PaginatorModel(pages: [1, 2, 3], pageIndex: 1)) {
    state = PaginatorModel(pages: [1, 2, 3], pageIndex: 1);
  }

  void initPager(int maxPage) {
    if (maxPage < 3) {
      state = PaginatorModel(pages: [1, 2], pageIndex: state.pageIndex);
    }
  }

  void nextPage(int maxPage) {
    if (state.pages.last + 3 <= maxPage) {
      state = PaginatorModel(pages: state.pages.map((e) => e + 3).toList(), pageIndex: state.pageIndex);
    } else {
      List<int> temp = [];
      for (int i = state.pages.last + 1; i <= maxPage; i++) {
        temp.add(i);
      }
      if (temp.isNotEmpty) {
        state = PaginatorModel(pages: temp.toList(), pageIndex: state.pageIndex);
      }
    }
  }

  void prevPage() {
    if (state.pages.first > 1) {
      if (state.pages.length < 3) {
        // log((state.pages.last % 3).toString());
        state = PaginatorModel(
            pages: [
              state.pages.last - (state.pages.last % 3) - 2,
              state.pages.last - (state.pages.last % 3) - 1,
              state.pages.last - (state.pages.last % 3),
            ].toList(),
            pageIndex: state.pageIndex);
      } else {
        state = PaginatorModel(pages: state.pages.map((e) => e - 3).toList(), pageIndex: state.pageIndex);
      }
    }
  }

  void setPageIndex(int val) {
    state = PaginatorModel(pages: state.pages, pageIndex: val);
  }

  void backToFirst() {
    state = PaginatorModel(pages: [1, 2, 3], pageIndex: state.pageIndex);
  }
}

class PageNotifier extends StateNotifier<List<int>> {
  PageNotifier() : super([1, 2, 3]);

  void nextPage() {
    state = state.map((e) => e + 3).toList();
  }

  void prevPage() {
    if (state.first > 1) {
      state = state.map((e) => e - 3).toList();
    }
  }

  void backToFirst() {
    state = [1, 2, 3];
  }
}
