import 'package:flutter/material.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/message_page/message_card.dart';
import 'package:polimi_app/screens/profile/components/review_card.dart';
import 'package:provider/provider.dart';

class ListMessagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return FutureBuilder(
      future: model.getMessagesByUser,
      builder: (context, snap) {
        if (!snap.hasData) return SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: model.user.messagesForMe['length'],
            itemBuilder: (context, index) => MessageCard(
              itemIndex: index,
              message: model.user.messagesForMe['messages'][index],
            ),
          ),
        );
      },
    );
  }
}
