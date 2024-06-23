class Meta {
  int? currPage;
  int? count;
  int? lastPage;
  int? limit;

  Meta({this.currPage, this.lastPage, this.limit});

  Meta.fromJson(Map<String, dynamic> json) {
    currPage = json['current_page'];
    count = json['count'];
    lastPage = json['last_page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['curr_page'] = currPage;
    data['count'] = count;
    data['count_page'] = lastPage;
    data['limit'] = limit;
    return data;
  }
}
