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
        return Container(
          height: MediaQuery.of(context).size.height / 2 - 20,
          child: ListView.builder(
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
