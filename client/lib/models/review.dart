import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/models/user/user.dart';

class Review {
  String _review;
  double _rating;
  DateTime _createdAt;
  User _userReviewed;
  User _userReviewer;

  Review({review, rating, createdAt, userReviewed, userReviewer})
      : _review = review,
        _rating = rating,
        _createdAt = createdAt,
        _userReviewed = userReviewed,
        _userReviewer = userReviewer;

  ///used to create a new review object when I fetch reviews from server
  factory Review.fromMap(Map<String, dynamic> payload, Model model) {
    try {
      return Review(
          createdAt: DateTime.parse(payload['createdAt']),
          userReviewed: model.selectedUser,
          userReviewer: StandardUser(username: payload['user']['username']),
          rating: payload['rating'].toDouble(),
          review: payload['review']
      );
    }catch (e) {
      print(e);
      return null;
    }
  }

  ///used when posting a new review
  Map toMap() {
    return {
      "userReviewed": _userReviewed.username,
      "review" : _review,
      "rating" : _rating,
    };
  }

  String get review => _review;

  double get rating => _rating;

  DateTime get createdAt => _createdAt;

  User get userReviewed => _userReviewed;

  User get userReviewer => _userReviewer;
}


