import 'package:devinfo/deviceinfo1.dart';
import 'package:devinfo/deviceinfo2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DevInfo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Device Info Tabs'),
              centerTitle: true,
              bottom: const TabBar(tabs: [
                Tab(
                  text: 'Device 1',
                ),
                Tab(
                  text: 'Device 2',
                ),
              ]),
            ),
            body: const TabBarView(
              children: [
                DeviceInfo1('Device index :1'),
                DeviceInfo2('Device index :1'),
              ],
            )));
  }
}
