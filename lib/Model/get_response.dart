class getres {
  List<Records>? records;
  String? message;

  getres({this.records, this.message});

  getres.fromJson(Map<String, dynamic> json) {
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

  Records({this.id, this.name, this.email, this.fId, this.mood});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    fId = json['f_id'];
    mood = json['mood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['f_id'] = this.fId;
    data['mood'] = this.mood;
    return data;
  }
}
