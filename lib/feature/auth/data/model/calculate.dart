// import 'package:objectbox/objectbox.dart';

// import 'user.dart';

// @Entity()
// class Calculate {
//   int id = 0; // Auto-incremented ID

//   double bmi;

//   @Property(type: PropertyType.date)
//   DateTime date;

//   // Link back to the User entity
//   final user = ToOne<User>();

//   Calculate({
//     required this.bmi,
//     required this.date,
//   });

//   // Static methods to calculate BMI and BMR
//   static double calculateBMI(double weight, double height) {
//     return weight / ((height / 100) * (height / 100));
//   }

// }
