import '../enum/role.dart';
import 'user.dart';

class StandardUser extends User {
  StandardUser(
      {birth,
      gender,
      username,
      firstName,
      lastName,
      phone,
      city,
      role,
      ratingsQuantity,
      ratingsAverage,
      photo,
      jwt,
      available,
      nationality})
      : super(
            birth: birth,
            gender: gender,
            username: username,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            city: city,
            role: role,
            ratingsQuantity: ratingsQuantity,
            ratingsAverage: ratingsAverage,
            photo: photo,
            jwt: jwt,
            available: available,
            nationality: nationality);

  factory StandardUser.fromMap(Map<String, dynamic> payload, String jwt) {
    if (payload == null) return null;
    Map user = payload;
    var role = user['role'];
    var photo = user["photo"];
    var ratingsQuantity = user["ratingsQuantity"];
    var username = user["username"];
    var ratingsAverage = user["ratingsAverage"];
    var firstName = user["firstName"];
    var lastName = user["lastName"];
    var phone = user["phone"];
    var city = user["city"];
    var available = user["available"] as bool;
    var jwtToStore = jwt;
    var gender = user["gender"];
    var nationality = user["nationality"];
    var birth = user["birth"];
    var birthParsed = birth == null ? null : DateTime.parse(birth);

    return StandardUser(
        birth: birthParsed,
        available: available,
        city: city,
        firstName: firstName,
        lastName: lastName,
        jwt: jwtToStore,
        phone: phone,
        photo: photo,
        nationality: nationality,
        gender: gender,
        ratingsAverage: ratingsAverage,
        ratingsQuantity: ratingsQuantity,
        role: role,
        username: username);
  }

  /// {user: {role: admin, photo: default.jpg, ratingsQuantity: 0, _id: 5f831769ecb6ae1f908d073d, username: admin, email: admin@gmail.com,
  /// createdAt: 2020-10-11T14:32:09.726Z, __v: 0, id: 5f831769ecb6ae1f908d073d}, iat: 1602446717, exp: 1605038717}
/**
 * {status: success, user: {available: false, role: admin, photo: https://firebasestorage.googleapis.com/v0/b/baddy-f34f0.appspot.com/o/admin%2F1604328292670%2Fphoto.jpg?alt=media&token=a8c29af3-9e5a-441c-b192-bcaaa874286f,
 * ratingsQuantity: 0, _id: 5f9f29e49f806429c4094109, username: admin, email: admin@gmail.com, createdAt: 2020-11-01T21:34:28.582Z, __v: 0,
 * birth: 2000-01-01T00:00:00.000Z, firstName: gfdg, lastName: null, nationality: null, phone: null, id: 5f9f29e49f806429c4094109}}
 */
}
