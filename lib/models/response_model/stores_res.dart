class StoresRes {
  bool error;
  List<DataStoresRes> data;

  StoresRes({this.error, this.data});

  StoresRes.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = new List<DataStoresRes>();
      json['data'].forEach((v) {
        data.add(new DataStoresRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataStoresRes {
  List<dynamic> userDevice;
  List<dynamic> cameraDevice;
  List<dynamic> controllerDevice;
  List<dynamic> localServerDevice;
  List<String> owner;
  List<String> staff;
  List<dynamic> zone;
  String sId;
  String address;
  String name;
  String phone;
  String creater;
  String modifyAt;
  String createAt;

  DataStoresRes(
      {this.userDevice,
      this.cameraDevice,
      this.controllerDevice,
      this.localServerDevice,
      this.owner,
      this.staff,
      this.zone,
      this.sId,
      this.address,
      this.name,
      this.phone,
      this.creater,
      this.modifyAt,
      this.createAt});

  DataStoresRes.fromJson(Map<String, dynamic> json) {
    if (json['userDevice'] != null) {
      userDevice = new List<dynamic>();
      json['userDevice'].forEach((v) {
        userDevice.add(v);
      });
    }
    if (json['cameraDevice'] != null) {
      cameraDevice = new List<dynamic>();
      json['cameraDevice'].forEach((v) {
        cameraDevice.add(v);
      });
    }
    if (json['controllerDevice'] != null) {
      controllerDevice = new List<dynamic>();
      json['controllerDevice'].forEach((v) {
        controllerDevice.add(v);
      });
    }
    if (json['localServerDevice'] != null) {
      localServerDevice = new List<dynamic>();
      json['localServerDevice'].forEach((v) {
        localServerDevice.add(v);
      });
    }
    owner = json['owner'].cast<String>();
    staff = json['staff'].cast<String>();
    if (json['zone'] != null) {
      zone = new List<dynamic>();
      json['zone'].forEach((v) {
        zone.add(v);
      });
    }
    sId = json['_id'];
    address = json['address'];
    name = json['name'];
    phone = json['phone'];
    creater = json['creater'];
    modifyAt = json['modifyAt'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDevice != null) {
      data['userDevice'] = this.userDevice.map((v) => v.toJson()).toList();
    }
    if (this.cameraDevice != null) {
      data['cameraDevice'] = this.cameraDevice.map((v) => v.toJson()).toList();
    }
    if (this.controllerDevice != null) {
      data['controllerDevice'] =
          this.controllerDevice.map((v) => v.toJson()).toList();
    }
    if (this.localServerDevice != null) {
      data['localServerDevice'] =
          this.localServerDevice.map((v) => v.toJson()).toList();
    }
    data['owner'] = this.owner;
    data['staff'] = this.staff;
    if (this.zone != null) {
      data['zone'] = this.zone.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['address'] = this.address;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['creater'] = this.creater;
    data['modifyAt'] = this.modifyAt;
    data['createAt'] = this.createAt;
    return data;
  }
}
