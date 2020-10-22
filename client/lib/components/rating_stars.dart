import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rate;

  const RatingStars({Key key, this.rate = 0})
      : assert(rate != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        var currStar = index.toDouble() + 1;
        return Icon(
          rate >= currStar ? Icons.star : _calculateStar(currStar),
        );
      }),
    );
  }
  ///for example a rate of 3.4 is rounded to 3, a rate of 3.9 rounded to 3.5
  IconData _calculateStar(double currStar) {
    double diff = currStar - rate;
    if (diff <= 0.5) {
      return Icons.star_half_outlined;
    }
    else {
      return Icons.star_border;
    }
  }
}
