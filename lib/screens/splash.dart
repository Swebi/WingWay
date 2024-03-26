import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(10, 36, 56, 1),
        image: DecorationImage(
          image: AssetImage("assets/images/splash.jpeg"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter, // Align the image to the top center
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Shop",
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none, // Remove underline
            ),
          )
        ],
      ),
    );
  }
}
