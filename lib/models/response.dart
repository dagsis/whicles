class Response {
  List<String> errors = [];

  Response({required this.errors});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors.add(json['errors'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errors'] = this.errors;
    return data;
  }
}
