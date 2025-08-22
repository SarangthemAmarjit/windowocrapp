import 'package:flutter/material.dart';

class CardShuffleDemo extends StatefulWidget {
  const CardShuffleDemo({super.key});

  @override
  State<CardShuffleDemo> createState() => _CardShuffleDemoState();
}

class _CardShuffleDemoState extends State<CardShuffleDemo> with SingleTickerProviderStateMixin {
  bool _shuffled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Card 1 - Top
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              top: _shuffled ? size.height / 2 - 200 : size.height / 2 - 25,
              left: size.width / 2 - 50,
              child: _buildCard(Colors.red),
            ),

            // Card 2 - Right
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              top: size.height / 2 - 25,
              left: _shuffled ? size.width / 2 + 100 : size.width / 2 - 50,
              child: _buildCard(Colors.blue),
            ),

            // Card 3 - Bottom
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              top: _shuffled ? size.height / 2 + 150 : size.height / 2 - 25,
              left: size.width / 2 - 50,
              child: _buildCard(Colors.green),
            ),

            // Card 4 - Left
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              top: size.height / 2 - 25,
              left: _shuffled ? size.width / 2 - 200 : size.width / 2 - 50,
              child: _buildCard(Colors.orange),
            ),

            // Shuffle Button (center)
            Positioned(
              top: size.height / 2 - 25,
              left: size.width / 2 - 25,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _shuffled = !_shuffled;
                  });
                },
                child: const Icon(Icons.play_arrow),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Color color) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
    );
  }
}
