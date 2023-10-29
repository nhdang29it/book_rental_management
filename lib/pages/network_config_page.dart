import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/network_provider.dart';


class NetWorkConfigPage extends StatelessWidget {
  const NetWorkConfigPage({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/networkConfig", "bot_nav_idx": 4};

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Cài đặt mạng"),
    //   ),
    //   body: const NetWorkConfigScreen(),
    // );
    return const NetWorkConfig();
  }
}

class NetWorkConfigScreen extends ConsumerWidget {
  const NetWorkConfigScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final network = ref.watch(networkProvider);
    TextEditingController urlController = TextEditingController(text: network.host);
    TextEditingController indexController = TextEditingController(text: network.index);
    TextEditingController portController = TextEditingController(text: network.port.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: urlController,
            decoration: const InputDecoration(
              label: Text(
                  'ip: ',
                  style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.text,
            controller: portController,
            decoration: const InputDecoration(
              label: Text(
                  'port: ',
                  style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),

            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.text,
            controller: indexController,
            decoration: const InputDecoration(
              label: Text(
                  'index: ',
                  style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: (){
              ref.read(networkProvider.notifier).changeConfigure(
                host: urlController.text,
                index: indexController.text,
                port: int.parse(portController.text)
              );

            },
            child: const Text("Lưu"),
          )
        ],
      ),
    );
  }
}

class NetWorkConfig extends StatefulWidget {
  const NetWorkConfig({super.key});

  @override
  State<NetWorkConfig> createState() => _NetWorkConfigState();
}

class _NetWorkConfigState extends State<NetWorkConfig> {

  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt mạng"),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                isEnable = !isEnable;
              });
            },
            icon: Icon(isEnable ? Icons.settings : Icons.edit),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child ){
          final network = ref.watch(networkProvider);
          TextEditingController urlController = TextEditingController(text: network.host);
          TextEditingController indexController = TextEditingController(text: network.index);
          TextEditingController portController = TextEditingController(text: network.port.toString());

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  controller: urlController,
                  enabled: isEnable,
                  decoration: const InputDecoration(
                    label: Text(
                        'ip: ',
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: portController,
                  enabled: isEnable,
                  decoration: const InputDecoration(
                    label: Text(
                        'port: ',
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),

                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: indexController,
                  enabled: isEnable,
                  decoration: const InputDecoration(
                    label: Text(
                        'index: ',
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: isEnable ? (){
                    ref.read(networkProvider.notifier).changeConfigure(
                        host: urlController.text,
                        index: indexController.text,
                        port: int.parse(portController.text)
                    );

                    Navigator.pop(context);
                  } : null,
                  child: const Text("Lưu thay đổi"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


