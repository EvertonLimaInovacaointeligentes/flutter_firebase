import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_project/firebase_auth/auth_interface.dart';
import 'package:firebase_project/firebase_auth/custom_firebase_auth.dart';
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
  final AuthInterface _auth = CustomFirebaseAuth();
  var controllerUser = TextEditingController();
  var controllerPass = TextEditingController();

  String? erroMsg;

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
            TextFormField(
              controller: controllerUser,
              decoration: const InputDecoration(
                label: Text('Usuário'),
              ),
            ),
            TextFormField(
              controller: controllerPass,
              decoration: const InputDecoration(
                label: Text('Senha'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String user = controllerUser.text;
                String pass = controllerPass.text;

                var result = await _auth.login(user, pass);
                if (result.isSuccess) {
                  setState(() => erroMsg = null);
                  print('Sucess Login');
                } else {
                  setState(() => erroMsg = result.msgError);
                }
              },
              child: const Text('Acessar'),
            ),
            ElevatedButton(
              onPressed: () async {
                String user = controllerUser.text;
                String pass = controllerUser.text;

                var result = await _auth.register(user, pass);
                if (result.isSuccess) {
                  setState(() => erroMsg = null);
                  print('Sucess Register');
                } else{
                  setState(() =>erroMsg = result.msgError);
                }
              },
              child: const Text('Register'),
            ),
            if(erroMsg !=null) Text(erroMsg!),
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance
                    .log("Ocorreu uma Exception manual!");
                throw Exception('Testar Erro manual');
              },
              child: const Text('Btn'),
            ),
            CustomVisibleRCWidget(
              rmKey: 'RC',
              defaultValue: CustomRemoteConfig()
                  .getValueOrDefault(key: 'NewHome', defaultValue: false),
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
          setState(() {});
          print('Executou o botao');
        },
      ),
    );
  }
}
