// ignore_for_file: must_be_immutable

import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_controllers/page_controller.dart';
import 'package:axlerate/src/common/common_widgets/page_indicator_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:math';

@Deprecated('AxlePaginator is deprecated. Switch to \'AxleSimplePaginator\'')
class AxlePaginator extends ConsumerStatefulWidget {
  const AxlePaginator({
    required this.totalCount,
    required this.pageSize,
    required this.stateNotifier,
    required this.onChange,
    super.key,
  });

  final int totalCount, pageSize;
  final StateNotifierProvider<PageNotifierNew, PaginatorModel> stateNotifier;
  final Function(int) onChange;

  @override
  ConsumerState<AxlePaginator> createState() => _AxlePaginatorState();
}

// ignore: deprecated_member_use_from_same_package
class _AxlePaginatorState extends ConsumerState<AxlePaginator> {
  late int maxPage;

  @override
  void initState() {
    maxPage = (widget.totalCount ~/ widget.pageSize).ceil();
    Future(() {
      if (maxPage < 3) {
        ref.read(widget.stateNotifier.notifier).initPager(maxPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    PaginatorModel value = ref.watch(widget.stateNotifier);

    return widget.totalCount <= 15
        ? const SizedBox()
        : Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
            children: [
              PageIndicatorCard(
                value: '<',
                onPress: ref.read(widget.stateNotifier.notifier).prevPage,
                onLongPressed: ref.read(widget.stateNotifier.notifier).backToFirst,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 130,
                  height: 40.0,
                  child: ListView.builder(
                    itemCount: value.pages.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return PageIndicatorCard(
                        value: value.pages[index].toString(),
                        isSelected: value.pages[index] == value.pageIndex,
                        onPress: () async {
                          ref.read(widget.stateNotifier.notifier).setPageIndex(value.pages[index]);

                          widget.onChange(value.pages[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
              PageIndicatorCard(
                value: '>',
                onPress: (() => ref.read(widget.stateNotifier.notifier).nextPage(maxPage)),
              ),
            ],
          );
  }
}

class AxleSimplePaginator extends StatelessWidget {
  AxleSimplePaginator(
      {super.key,
      required this.currentPage,
      required this.pageSize,
      required this.totalItems,
      required this.onChange}) {
    pageCount = (totalItems / pageSize).ceil();
  }
  final int currentPage;
  late int pageCount;
  final int pageSize;
  final int totalItems;
  final Function(int) onChange;

  final maxPagesToShow = 3;

  List<int> listOfPages(int activePage, int total, int pagesToShow) {
    int startPage = max(1, activePage - ((pagesToShow / 2).floor()));
    // int lastPage = min(activePage + ((pagesToShow / 2).floor()), total);
    List<int> pages = [];
    if (activePage == total && startPage > 1) pages.add(startPage - 1);
    for (int i = 0; i < pagesToShow && startPage <= total; i++) {
      pages.add(startPage++);
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    List<int> pages = listOfPages(currentPage, pageCount, maxPagesToShow);
    List<Widget> pageButtons = [];

    for (int page in pages) {
      pageButtons.add(
        PageIndicatorCard(
          value: '$page',
          onPress: () {
            onChange(page);
          },
          isSelected: currentPage == page,
        ),
      );
    }
    // Add buttons to go to first and last page
    pageButtons.insert(
      0,
      Tooltip(
        message: "First",
        child: PageIndicatorCard(
          value: '|<',
          disabled: currentPage == 1,
          onPress: currentPage == 1
              ? null
              : () {
                  onChange(1);
                },
        ),
      ),
    );
    pageButtons.add(
      Tooltip(
        message: "Last",
        child: PageIndicatorCard(
          value: '>|',
          disabled: currentPage == pageCount,
          onPress: currentPage == pageCount
              ? null
              : () {
                  onChange(pageCount);
                },
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: totalItems > 1 ? pageButtons : const [SizedBox()],
    );
  }
}
