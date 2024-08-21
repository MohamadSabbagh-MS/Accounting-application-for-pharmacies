class loginModel {
  String? status;
  Data? data;

  loginModel({this.status, this.data});

  loginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? parPass;
  int? code;

  Data({this.parPass, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    parPass = json['par_pass'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['par_pass'] = this.parPass;
    data['code'] = this.code;
    return data;
  }
}
