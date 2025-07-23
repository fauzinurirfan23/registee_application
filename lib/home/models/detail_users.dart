class GetDetailUser {
  int? total;
  int? page;
  int? limit;
  List<UsersDetail>? users;

  GetDetailUser({this.total, this.page, this.limit, this.users});

  GetDetailUser.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    if (json['users'] != null) {
      users = <UsersDetail>[];
      json['users'].forEach((v) {
        users!.add(new UsersDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersDetail {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? address;

  UsersDetail({this.id, this.username, this.email, this.phone, this.address});

  UsersDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
