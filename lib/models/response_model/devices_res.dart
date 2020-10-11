class DevicesRes {
  bool error;
  List<DataDevicesRes> data;

  DevicesRes({this.error, this.data});

  DevicesRes.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = new List<DataDevicesRes>();
      json['data'].forEach((v) {
        data.add(new DataDevicesRes.fromJson(v));
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

class DataDevicesRes {
  StatusDeviceRes status;
  int type;
  String stateActive;
  String stateConfig;
  String sId;
  String name;
  String description;
  String mode;
  String controller;
  int controllerType;
  String store;
  String userCreate;
  String modifyAt;
  String createAt;
  String controllerMetaInfo;
  String localServer;
  String userUpdate;
  UserType userType;
  String zone;
  List<ListState> listState;

  DataDevicesRes(
      {this.status,
      this.type,
      this.stateActive,
      this.stateConfig,
      this.sId,
      this.name,
      this.description,
      this.mode,
      this.controller,
      this.controllerType,
      this.store,
      this.userCreate,
      this.modifyAt,
      this.createAt,
      this.controllerMetaInfo,
      this.localServer,
      this.userUpdate,
      this.userType,
      this.zone,
      this.listState});

  DataDevicesRes.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null
        ? new StatusDeviceRes.fromJson(json['status'])
        : null;
    type = json['type'];
    stateActive = json['stateActive'];
    stateConfig = json['stateConfig'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    mode = json['mode'];
    controller = json['controller'];
    controllerType = json['controllerType'];
    store = json['store'];
    userCreate = json['userCreate'];
    modifyAt = json['modifyAt'];
    createAt = json['createAt'];
    controllerMetaInfo = json['controllerMetaInfo'];
    localServer = json['localServer'];
    userUpdate = json['userUpdate'];
    userType = json['userType'] != null
        ? new UserType.fromJson(json['userType'])
        : null;
    zone = json['zone'];
    if (json['listState'] != null) {
      listState = new List<ListState>();
      json['listState'].forEach((v) {
        listState.add(new ListState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['type'] = this.type;
    data['stateActive'] = this.stateActive;
    data['stateConfig'] = this.stateConfig;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['mode'] = this.mode;
    data['controller'] = this.controller;
    data['controllerType'] = this.controllerType;
    data['store'] = this.store;
    data['userCreate'] = this.userCreate;
    data['modifyAt'] = this.modifyAt;
    data['createAt'] = this.createAt;
    data['controllerMetaInfo'] = this.controllerMetaInfo;
    data['localServer'] = this.localServer;
    data['userUpdate'] = this.userUpdate;
    if (this.userType != null) {
      data['userType'] = this.userType.toJson();
    }
    data['zone'] = this.zone;
    if (this.listState != null) {
      data['listState'] = this.listState.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusDeviceRes {
  String sId;
  String signal;
  String name;
  String meta;
  String log;

  StatusDeviceRes({this.sId, this.signal, this.name, this.meta, this.log});

  StatusDeviceRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    signal = json['signal'];
    name = json['name'];
    meta = json['meta'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['signal'] = this.signal;
    data['name'] = this.name;
    data['meta'] = this.meta;
    data['log'] = this.log;
    return data;
  }
}

class UserType {
  String keyName;
  String icon;
  String sId;

  UserType({this.keyName, this.icon, this.sId});

  UserType.fromJson(Map<String, dynamic> json) {
    keyName = json['keyName'];
    icon = json['icon'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyName'] = this.keyName;
    data['icon'] = this.icon;
    data['_id'] = this.sId;
    return data;
  }
}

class ListState {
  String sId;
  String name;
  String signal;
  String meta;
  String icon;

  ListState({this.sId, this.name, this.signal, this.meta, this.icon});

  ListState.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    signal = json['signal'];
    meta = json['meta'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['signal'] = this.signal;
    data['meta'] = this.meta;
    data['icon'] = this.icon;
    return data;
  }
}
