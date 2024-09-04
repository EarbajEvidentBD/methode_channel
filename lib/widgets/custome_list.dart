import 'package:flutter/material.dart';
import 'package:methodechannel/data/post.dart';

class CustomListItem extends StatelessWidget {
  final Post post;

  CustomListItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Stack with Gradient Container and CircleAvatar
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff4d6139),
                        Color(0xff7d6bc1),
                        Color(0xff894d6a),
                      ], // Multiple colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors
                      .transparent, // Make the CircleAvatar background transparent
                  child: Text(
                    post.id.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
                width:
                    16), // Adds spacing between Gradient Container and Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow:
                        TextOverflow.ellipsis, // Adds ellipsis for long title
                    maxLines:
                        1, // Ensures the title does not wrap to the next line
                  ),
                  SizedBox(height: 4), // Adds spacing between title and body
                  Text(
                    post.body,
                    style: TextStyle(color: Colors.black54),
                    overflow: TextOverflow
                        .ellipsis, // Adds ellipsis for long body text
                    maxLines: 2, // Limits body text to 2 lines
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
