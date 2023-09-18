
class NetWorkConfigure {
  final String host;
  final int port;
  final String index;
  NetWorkConfigure({required this.host, required this.port, required this.index});


  NetWorkConfigure copyWith({String? newHost, int? newPort, String? newIndex}){
    return NetWorkConfigure(
        host: newHost ?? host,
        port: newPort ?? port,
        index: newIndex ?? index
    );
  }

}