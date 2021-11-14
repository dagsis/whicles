class Response {
  List<Null> errors = [];

  Response({required this.errors});

  Response.fromJson(Map<String, dynamic> json) {
    errors.add(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errors'] = this.errors;
    return data;
  }
}
