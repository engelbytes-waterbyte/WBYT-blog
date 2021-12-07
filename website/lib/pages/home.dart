import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/idol-sketch.png"),
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(children: const [
            Text("Icon", style: TextStyle(fontSize: 25)),
            Text("Blogs", style: TextStyle(fontSize: 25))
          ]),
          Row(children: const [
            Text("Icon", style: TextStyle(fontSize: 25)),
            Text("Projects", style: TextStyle(fontSize: 25))
          ]),
          Row(children: const [
            Text("Icon", style: TextStyle(fontSize: 25)),
            Text("Team", style: TextStyle(fontSize: 25))
          ]),
        ])
      ]),
    );
  }
}
