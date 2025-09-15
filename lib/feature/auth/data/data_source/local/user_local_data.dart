// import 'package:objectbox/objectbox.dart';

// import '../../model/calculate.dart';
// import '../../model/user.dart';

// class UserLocalData {
//   final Store store;
//   late final Box<User> _userBox;
//   late final Box<Calculate> _calculateBox;
//   UserLocalData(this.store) {
//     _userBox = Box<User>(store);
//     _calculateBox = Box<Calculate>(store);
  
//   }

//   void saveUser(User user) => _userBox.put(user);

//   User? getUser(int id) => _userBox.get(id);

//   List<User> getAllUser() => _userBox.getAll();

//   void clearUser() => _userBox.removeAll();

//   void saveCalculate(Calculate calculate) => _calculateBox.put(calculate);
// }