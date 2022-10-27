import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:memo_me/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, settings),
              icon: Icon(Icons.settings))
        ],
      ),
      drawer: drawerView(),
      body: bodyView(),
    );
  }

  Drawer drawerView() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text("Drawer Header"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Center(
                  child: Text("Text"),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget bodyView() {
    return Container();
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 60));
    FlutterNativeSplash.remove();
  }
}
