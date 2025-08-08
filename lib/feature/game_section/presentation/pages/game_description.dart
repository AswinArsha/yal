
import 'package:flutter/material.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/see_more.dart';

class GameDescription extends StatelessWidget {
  const GameDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandableTextWithSeeMore(
              text: 'Details',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Game Controls',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Glove Camel is a 2D browser game similar to the famous T-Rex game, worthy of mention. The events of this game take place in the vast desert, where the user plays the role of a camel whose mission is to overcome challenges.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Introduction',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Glove Camel is a 2D browser game similar to the famous T-Rex game, worthy of mention. The events of this game take place in the vast desert, where the user plays the role of a camel whose mission is to overcome challenges.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Introduction',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Glove Camel is a 2D browser game similar to the famous T-Rex game, worthy of mention. The events of this game take place in the vast desert, where the user plays the role of a camel whose mission is to overcome challenges.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
