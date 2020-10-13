import '../enum/role.dart';
import 'user.dart';

class StandardUser extends User {
  StandardUser({
    username,
    firstName,
    lastName,
    phone,
    address,
    email,
    role,
    ratingsQuantity,
    ratingsAverage,
    photo,
    jwt,
  }) : super(
            username: username,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            address: address,
            email: email,
            role: role,
            ratingsQuantity: ratingsQuantity,
            ratingsAverage: ratingsAverage,
            photo: photo,
            jwt: jwt);

  factory StandardUser.fromMap(Map<String, dynamic> payload, String jwt) {
    if (payload == null) return null;
    Map user = payload["user"];
    var role = Role.standard;
    var photo = user["photo"];
    var ratingsQuantity = user["ratingsQuantity"];
    var username = user["username"];
    var ratingsAverage = user["ratingsAverage"];
    var email = user["email"];
    var firstName = user["firstName"];
    var lastName = user["lastName"];
    var phone = user["phone"];
    var address = user["address"];

    return StandardUser(
        address: address,
        email: email,
        firstName: firstName,
        lastName: lastName,
        jwt: jwt,
        phone: phone,
        photo: photo,
        ratingsAverage: ratingsAverage,
        ratingsQuantity: ratingsQuantity,
        role: role,
        username: username);
  }

  /// {user: {role: admin, photo: default.jpg, ratingsQuantity: 0, _id: 5f831769ecb6ae1f908d073d, username: admin, email: admin@gmail.com,
  /// createdAt: 2020-10-11T14:32:09.726Z, __v: 0, id: 5f831769ecb6ae1f908d073d}, iat: 1602446717, exp: 1605038717}

}
