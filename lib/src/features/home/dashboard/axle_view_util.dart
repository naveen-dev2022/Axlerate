import 'package:axlerate/src/features/home/dashboard/page_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPageNameProvider = StateProvider<String>((ref) {
  return axlePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPage = ref.watch(selectedPageNameProvider);
  return axlePages[selectedPage]!;
});

/* 

axlePages - contains list of items to show in the side menu as a key and value as WidgetBuilder
            
*/

final axlePages = <String, WidgetBuilder>{
  PageName.dashboard: (_) => Scaffold(
        backgroundColor: Colors.blue.shade200,
      ),
  PageName.partners: (_) => Scaffold(
        backgroundColor: Colors.indigo.shade200,
      ),
  PageName.customers: (_) => Scaffold(
        backgroundColor: Colors.amberAccent.shade200,
      ),
  PageName.profile: (_) => Scaffold(
        backgroundColor: Colors.purpleAccent.shade200,
      ),
  PageName.user: (_) => Scaffold(
        backgroundColor: Colors.redAccent.shade200,
      ),
};

final List<String> axlePagesIcons = ['assets/new_assets/icons/dashboard_icon.svg'];
