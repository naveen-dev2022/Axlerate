class ListInvoiceCustomerQuery {
  //final int? size;
  //final int? pageindex;
  final String? searchText;

  ListInvoiceCustomerQuery({
    //  this.size,
    // this.pageindex,
    this.searchText,
  });

  Map<String, dynamic> toJson() {
    return {
      //'size': size,
      //'pageindex': pageindex,
      'searchText': searchText,
    };
  }
}
