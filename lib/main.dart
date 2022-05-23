import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/firebase_messaging/custom_firebase_messaging.dart';
import 'package:firebase_project/pages/home.dart';
import 'package:firebase_project/remote_config/custom_remote_config.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CustomRemoteConfig().initialize();
  await CustomFirebaseMessaging().inicialize(
    callback: () => CustomRemoteConfig().forceFetch(),
  );
  await CustomFirebaseMessaging().getTokenFirebase();

  //projeto melhorado abaixo
  //WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp();

  //await CustomRemoteConfig().initialize();

  //await CustomFirebaseMessaging().inicialize(
  //callback: () => CustomRemoteConfig().forceFetch(),
  // );
  //await CustomFirebaseMessaging().getTokenFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (_) => const Home(title: 'HomePage'),
        '/virtual': (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Virtual Page'),
              ),
              body: const SizedBox.expand(
                child: Center(
                  child: Text('Virtual Page'),
                ),
              ),
            )
      },
    );
  }
}