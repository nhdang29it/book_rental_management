import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/network_provider.dart';


class NetWorkConfigPage extends StatelessWidget {
  const NetWorkConfigPage({super.key});

  static const Map<String,dynamic> myProperty = {"routeName": "/networkConfig", "bot_nav_idx": 4};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt mạng"),
      ),
      body: const NetWorkConfigScreen(),
    );
  }
}

class NetWorkConfigScreen extends ConsumerWidget {
  const NetWorkConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final network = ref.watch(networkProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text("url: ${network.host}"),
          Text("port: ${network.port}"),
          Text("index: ${network.index}"),
          const Divider(),
          TextField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text(
                  'url: ',
                  style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),

            ),
            onSubmitted: (value){
              ref.read(networkProvider.notifier).changeConfigure(host: value.toString());
            },
          ),
          // ElevatedButton(
          //   onPressed: (){
          //     ref.read(networkProvider.notifier).changeConfigure(host: "192.168.1.25");
          //   },
          //   child: Text("change url"),
          // )
        ],
      ),
    );
  }
}

