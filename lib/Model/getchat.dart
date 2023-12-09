class getchat {
  List<Records>? records;
  String? message;

  getchat({this.records, this.message});

  getchat.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Records {
  String? id;
  String? name;
  String? email;
  String? fId;
  String? mood;
  String? first;
  String? closeFriend;

  Records(
      {this.id,
        this.name,
        this.email,
        this.fId,
        this.mood,
        this.first,
        this.closeFriend});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    fId = json['f_id'];
    mood = json['mood'];
    first = json['first'];
    closeFriend = json['close_friend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['f_id'] = this.fId;
    data['mood'] = this.mood;
    data['first'] = this.first;
    data['close_friend'] = this.closeFriend;
    return data;
  }
}
