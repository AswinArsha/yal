
import 'package:flutter/material.dart';

class ExpandableTextWithSeeMore extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableTextWithSeeMore({
    super.key,
    required this.text,
    this.maxLines = 2,
    this.style,
  });

  @override
  State<ExpandableTextWithSeeMore> createState() =>
      _ExpandableTextWithSeeMoreState();
}

class _ExpandableTextWithSeeMoreState extends State<ExpandableTextWithSeeMore> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: widget.style);
        final tp = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final exceeded = tp.didExceedMaxLines;

        if (_expanded || !exceeded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.text, style: widget.style),
              if (exceeded)
                GestureDetector(
                  onTap: () => setState(() => _expanded = false),
                  child: const Text('See less',
                      style: TextStyle(color: Colors.amber)),
                ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                style: widget.style,
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
              ),
              GestureDetector(
                onTap: () => setState(() => _expanded = true),
                child: const Text(
                  'See more',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
