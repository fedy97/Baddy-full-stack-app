import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/models/user/user.dart';

class Message {
  String _message;
  DateTime _createdAt;
  User _userMessaged;
  User _userMessageer;

  Message({message, createdAt, userMessaged, userMessageer})
      : _message = message,
        _createdAt = createdAt,
        _userMessaged = userMessaged,
        _userMessageer = userMessageer;

  ///used to create a new message object when I fetch messages from server
  factory Message.fromMap(Map<String, dynamic> payload, Model model) {
    try {
      return Message(
          createdAt: DateTime.parse(payload['createdAt']),
          userMessaged: model.selectedUser,
          userMessageer: StandardUser(username: payload['user']['username']),
          message: payload['message']
      );
    }catch (e) {
      print(e);
      return null;
    }
  }

  ///used when posting a new message
  Map toMap() {
    return {
      "userMessaged": _userMessaged.username,
      "message" : _message,
    };
  }

  String get message => _message;

  DateTime get createdAt => _createdAt;

  User get userMessaged => _userMessaged;

  User get userMessageer => _userMessageer;
}


