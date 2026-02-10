import 'package:flutter/material.dart';
import 'package:frisky_fruits/core/widgets/frisky_button.dart';
import 'package:frisky_fruits/features/home/screens/home_screen.dart';
import 'package:frisky_fruits/features/root/screens/root_screen.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: .start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFF2994A),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RootScreen()))
                  ),
                ),
                SizedBox(width: 50),
                Text('Write Review ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Tell Us to Improve",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, height: 1.4),
            ),
            const SizedBox(height: 30),

            // 2. Rating Display
            const Text(
              "5.0",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => const Icon(
                Icons.star,
                color: Color(0xFFFFCC4D),
                size: 40,
              )),
            ),
            const SizedBox(height: 40),

            // 3. Review Text Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let us know what you think",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Write your review here",
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color(0xFFF2994A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color(0xFFF2994A), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 4. Done Button
            FriskyButton(
              text: 'DONE',
              onPressed: () {
                // Logic to save review and return home
                Navigator.push(context, MaterialPageRoute(builder: (context) => RootScreen()));
              },
              textColor: Colors.black,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}