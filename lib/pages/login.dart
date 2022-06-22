import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_project/firebase_auth/auth_interface.dart';
import 'package:firebase_project/firebase_auth/custom_firebase_auth.dart';
import 'package:firebase_project/remote_config/custom_remote_config.dart';
import 'package:firebase_project/remote_config/custom_visible_rc_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({Key? key,required this.title}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthInterface _auth = CustomFirebaseAuth();
  var controllerUser = TextEditingController();
  var controllerPass = TextEditingController();

  String? erroMsg;
  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  setState(() => erroMsg = result.msgError);
                }
              },
              child: const Text('Acessar'),
            ),
            if(erroMsg !=null) Text(erroMsg!),
          ],
        ),
      ),
    );
  }
}
