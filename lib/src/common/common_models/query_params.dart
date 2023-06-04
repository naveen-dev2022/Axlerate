// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class QueryParams {
  int? size;
  int? pageIndex;
  String? searchText;

  QueryParams({
    this.size = 15,
    this.pageIndex = 1,
    this.searchText,
  });

  set setSearchText(String val) {
    searchText = val;
  }
}
