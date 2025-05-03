import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BallPage(),
      ),
    );

class BallPage extends StatelessWidget {
  const BallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.9),
        title: Text(
          'Ask Me Anything',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({super.key});

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballnumber = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          setState(() {
            ballnumber = Random().nextInt(4) + 1;
          });
        },
        child: Center(
          child: Image.asset('images/ball$ballnumber.png'),
        ),
      ),
    );
  }
}
