import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/network_model.dart';

class NetWorkNotifier extends StateNotifier<NetWorkConfigure>{
  NetWorkNotifier() : super(NetWorkConfigure(host: "192.168.1.11", port: 9200, index: "books"));

  void changeConfigure({String? host, int? port, String? index}){
    state = state.copyWith(newHost: host, newPort: port, newIndex: index);
  }

  String getHost () => state.host;
  int getPort () => state.port;
  String getIndex () => state.index;

  NetWorkConfigure getNetWork () => state.copyWith();

}

final networkProvider = StateNotifierProvider<NetWorkNotifier, NetWorkConfigure>((ref) {
  return NetWorkNotifier();
});

