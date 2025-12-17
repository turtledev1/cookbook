enum SearchFilter {
  all,
  name,
  ingredients,
  tags,
}

extension SearchFilterExtension on SearchFilter {
  String get label {
    switch (this) {
      case SearchFilter.all:
        return 'All';
      case SearchFilter.name:
        return 'Name';
      case SearchFilter.ingredients:
        return 'Ingredients';
      case SearchFilter.tags:
        return 'Tags';
    }
  }
}
