import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime now = DateTime.now();

class UserWelcome extends StatelessWidget {
  String username;
  String imagePath;

  UserWelcome(this.username, this.imagePath, {super.key});
  String formattedDate = DateFormat('MMM d').format(now);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, $username",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Today's $formattedDate",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.39),
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        // Add spacing between image and text

        ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 55,
            height: 55,
          ),
        ),
      ],
    );
  }
}
