class AllData {
  List<Data>? data;

  AllData({this.data});

  AllData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  String? password;
  String? fId;
  String? mood;
  String? chat;

  Data(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.fId,
        this.mood,
        this.chat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    fId = json['f_id'];
    mood = json['mood'];
    chat = json['chat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['f_id'] = this.fId;
    data['mood'] = this.mood;
    data['chat'] = this.chat;
    return data;
  }
}
