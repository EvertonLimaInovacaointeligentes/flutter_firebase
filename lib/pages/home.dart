import 'package:firebase_project/remote_config/custom_remote_config.dart';
import 'package:firebase_project/remote_config/custom_visible_rc_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: CustomRemoteConfig()
                .getValueOrDefault(key: 'NewHome', defaultValue: false)
            ? Colors.greenAccent
            : Colors.red,
      ),
      body: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Bem vindo a home page',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            CustomVisibleRCWidget(
              rmKey: 'RC',
              defaultValue: CustomRemoteConfig().getValueOrDefault(key: 'NewHome', defaultValue: false),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await CustomRemoteConfig().forceFetch();
          print('Executou o botao');
        },
      ),
    );
  }
}
