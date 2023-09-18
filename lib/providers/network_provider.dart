import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/network_model.dart';

class NetWorkProvider extends StateNotifier<NetWorkConfigure>{
  NetWorkProvider() : super(NetWorkConfigure(host: "localhost", port: 9200, index: "facebook"));

  void changeConfigure({String? host, int? port, String? index}){
    state = state.copyWith(newHost: host, newPort: port, newIndex: index);
  }

  String getHost () => state.host;
  int getPort () => state.port;
  String getIndex () => state.index;

  NetWorkConfigure getNetWork () => state.copyWith();

}

final networkProvider = StateNotifierProvider<NetWorkProvider, NetWorkConfigure>((ref) {
  return NetWorkProvider();
});
