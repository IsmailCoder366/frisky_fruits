import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/frisky_button.dart';

class CongratulationsDialog extends StatefulWidget {
  final String userName;
  final VoidCallback onSignIn;

  const CongratulationsDialog({
    super.key,
    required this.userName,
    required this.onSignIn,
  });

  @override
  State<CongratulationsDialog> createState() => _CongratulationsDialogState();
}

class _CongratulationsDialogState extends State<CongratulationsDialog> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    // Logic: Initialize the controller and start the celebration immediately
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 3));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: ClipRRect( // Ensures confetti/images don't bleed out of rounded corners
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Confetti Animation Logic (Behind the text)
              ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
              ),

              // 2. The Static Celebration Image (Layered correctly)
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/celebration.png',
                  fit: BoxFit.contain,
                ),
              ),

              // 3. The Text Content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Congratulations!",
                    style: TextStyle(
                      color: AppColors.primaryOrange,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 140), // Space where the confetti/image is densest
                  FriskyButton(
                    textColor: Colors.black,
                    text: "Sign In",
                    onPressed: widget.onSignIn,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}