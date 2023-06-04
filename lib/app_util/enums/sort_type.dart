enum OrgsSort {
  asc,
  desc,
}

// * Returns Sort type string value
String getSortTypeString(OrgsSort selectedSortVal) {
  switch (selectedSortVal) {
    case OrgsSort.asc:
      return 'ASC';
    case OrgsSort.desc:
      return 'DESC';
  }
}
