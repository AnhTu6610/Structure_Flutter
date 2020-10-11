class ControlDeviceRes {
  bool error;
  Data data;

  ControlDeviceRes({this.error, this.data});

  ControlDeviceRes.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String sId;
  String device;
  String controller;
  String localServer;
  String store;
  String signal;
  State state;
  String sender;
  String modifyAt;
  String createAt;
  List<dynamic> controlResult;

  Data(
      {this.sId,
      this.device,
      this.controller,
      this.localServer,
      this.store,
      this.signal,
      this.state,
      this.sender,
      this.modifyAt,
      this.createAt,
      this.controlResult});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    device = json['device'];
    controller = json['controller'];
    localServer = json['localServer'];
    store = json['store'];
    signal = json['signal'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    sender = json['sender'];
    modifyAt = json['modifyAt'];
    createAt = json['createAt'];
    if (json['controlResult'] != null) {
      controlResult = new List<Null>();
      json['controlResult'].forEach((v) {
        controlResult.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['device'] = this.device;
    data['controller'] = this.controller;
    data['localServer'] = this.localServer;
    data['store'] = this.store;
    data['signal'] = this.signal;
    if (this.state != null) {
      data['state'] = this.state.toJson();
    }
    data['sender'] = this.sender;
    data['modifyAt'] = this.modifyAt;
    data['createAt'] = this.createAt;
    if (this.controlResult != null) {
      data['controlResult'] =
          this.controlResult.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class State {
  String sId;
  String name;
  String signal;

  State({this.sId, this.name, this.signal});

  State.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    signal = json['signal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['signal'] = this.signal;
    return data;
  }
}
