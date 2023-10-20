import 'package:flutter/material.dart';
import 'package:starwars/list.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListWidget()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         SizedBox(height: 50),
          Center(
            child: Image.asset(
              'assets/starwars.png',
              height: 200,
              width: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/thinkit.png',
                height: 150,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
