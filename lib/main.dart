import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/memory_card.dart';
import 'widgets/score_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MemoryDemo(title: 'Memory Demo'),
    );
  }
}

class MemoryDemo extends StatefulWidget {
  const MemoryDemo({super.key, required this.title});

  final String title;

  @override
  State<MemoryDemo> createState() => _MemoryDemoState();
}

class _MemoryDemoState extends State<MemoryDemo> {
  /// counter variables for tries and score
  /// [tries] is the number of tries the user has made
  /// [score] is the number of correct tries the user has made
  int tries = 0;
  int score = 0;

  /// list of flipped cards
  final List<int> _flippedCards = <int>[];
  final List<int> _matchedCards = <int>[];

  /// list of cards
  final List<String> _cards = <String>[
    'assets/images/batman.png',
    'assets/images/batman.png',
    'assets/images/elefant.png',
    'assets/images/elefant.png',
    'assets/images/eule.png',
    'assets/images/eule.png',
    'assets/images/hsv.png',
    'assets/images/hsv.png',
    'assets/images/hund.png',
    'assets/images/hund.png',
    'assets/images/pferdchen.png',
    'assets/images/pferdchen.png',
    'assets/images/pirat.png',
    'assets/images/pirat.png',
    'assets/images/stairs.png',
    'assets/images/stairs.png',
  ];

  /// timer for flipping cards back
  /// if they are not a match
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // shuffle cards
    _cards.shuffle();
    print("Cards: $_cards");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ScoreWidget(
                    title: "Tries",
                    score: tries,
                  ),
                ),
                Expanded(
                  child: ScoreWidget(
                    title: "Score",
                    score: score,
                  ),
                ),
              ],
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: List.generate(16, (index) {
                return Center(
                  child: MemoryCard(
                    id: index,
                    motive: _cards[index],
                    onTapped: _onCardTapped,
                    isFlipped: _flippedCards.contains(index),
                    isMatched: _matchedCards.contains(index),
                  ),
                );
              }),
            ),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text("Start a new Game"),
            ),
          ],
        ),
      ),
    );
  }

  /// reset the game
  void _resetGame() {
    setState(() {
      _flippedCards.clear();
      _matchedCards.clear();
      _cards.shuffle();
      tries = 0;
      score = 0;
    });
  }

  /// function on card tapped
  void _onCardTapped(int id) {
    setState(() {
      if (!_flippedCards.contains(id) && _flippedCards.length < 2) {
        _flippedCards.add(id);

        if (_flippedCards.length == 2) {
          print("Flipped cards: ${_cards[_flippedCards[0]]} and ${_cards[_flippedCards[1]]}");
          if (_cards[_flippedCards[0]] == _cards[_flippedCards[1]]) {
            _matchedCards.add(_flippedCards[0]);
            _matchedCards.add(_flippedCards[1]);
            score++;
          }
        }
      }
    });

    if (_flippedCards.length == 2) {
      _timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          _flippedCards.clear();
          tries++;
        });
      });
    }
  }
}
