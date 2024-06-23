class SearchEngine {
  String? query;
  Map<String, dynamic>? data;
  String? id;
  int currentPage;
  int maxPages;
  int limit;
  String? filter;
  Object? object;
  bool isLoading = true;

  SearchEngine({
    this.query,
    this.data,
    this.id,
    this.filter = "",
    this.isLoading = true,
    this.currentPage = 0,
    this.maxPages = 1,
    this.limit = 10,
    this.object,
  });

  updateCurrentPage(int page) => currentPage = page;

  toJson() {
    Map data = {};
    data["query"] = query;
    data["data"] = data;
    data["id"] = id;
    data["current_page"] = currentPage;
    return data;
  }
}
