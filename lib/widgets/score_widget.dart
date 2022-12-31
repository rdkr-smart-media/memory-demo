import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({Key? key, required this.score, required this.title}) : super(key: key);
  final int score;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            color: Colors.cyan,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$score",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    ));
  }
}
