import 'package:flutter/material.dart';

class MemoryCard extends StatefulWidget {
  const MemoryCard(
      {Key? key,
      required this.id,
      required this.motive,
      required this.onTapped,
      required this.isFlipped,
      required this.isMatched})
      : super(key: key);

  final int id;
  final String motive;
  final Function(int) onTapped;
  final bool isFlipped;
  final bool isMatched;

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isFlipped || widget.isMatched) {
          return;
        }
        widget.onTapped(widget.id);
      },
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: widget.isFlipped || widget.isMatched ? _buildMotive() : _buildMotive(),
        ),
      ),
    );
  }

  Widget _buildCover() {
    return Container(
      key: const ValueKey('cover'),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Image.asset(
            'assets/images/cover.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildMotive() {
    return Container(
      key: const ValueKey('motive'),
      color: Colors.white,
      child: Image.asset(
        widget.motive,
        fit: BoxFit.cover,
      ),
    );
  }
}
