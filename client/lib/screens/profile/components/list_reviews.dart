import 'package:flutter/material.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/profile/components/review_card.dart';
import 'package:provider/provider.dart';

class ListReviewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return FutureBuilder(
      future: model.getReviewsByUser,
      builder: (context, snap) {
        if (!snap.hasData) return SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          //or use Column with children ...list.map((review) { return ReviewCard()})
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.selectedUser.reviewsAboutMe['length'],
            itemBuilder: (context, index) => ReviewCard(
              itemIndex: index,
              review: model.selectedUser.reviewsAboutMe['reviews'][index],
            ),
          ),
        );
        return Container();
      },
    );
  }
}
