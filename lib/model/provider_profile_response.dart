import 'dart:convert';

// ProviderProfileResponse provideProfileFromJson(String str) => ProviderProfileResponse.fromJson(json.decode(str));
//
// String provideProfileToJson(ProviderProfileResponse data) => json.encode(data.toJson());

class ProviderProfileResponse {
  List<String>? addaAreas;
  List<Address>? address;
  String? email;
  String? name;
  int? phonenumber;
  List<ServiceLists>? serviceLists;
  String? userId;

  ProviderProfileResponse(
      {this.addaAreas,
        this.address,
        this.email,
        this.name,
        this.phonenumber,
        this.serviceLists,
        this.userId});

  ProviderProfileResponse.fromJson(Map<String, dynamic> json) {
    addaAreas = json['addaAreas'].cast<String>();
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    email = json['email'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    if (json['serviceLists'] != null) {
      serviceLists = <ServiceLists>[];
      json['serviceLists'].forEach((v) {
        serviceLists!.add(new ServiceLists.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addaAreas'] = this.addaAreas;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    if (this.serviceLists != null) {
      data['serviceLists'] = this.serviceLists!.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class Address {
  String? address1;
  String? address2;
  String? city;
  String? pincode;
  String? state;

  Address({this.address1, this.address2, this.city, this.pincode, this.state});

  Address.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    return data;
  }
}

class ServiceLists {
  String? name;
  double? price;
  List<SubCategory>? subCategory;

  ServiceLists({this.name, this.price, this.subCategory});

  ServiceLists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String? name;
  double? price;

  SubCategory({this.name, this.price});

  SubCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
