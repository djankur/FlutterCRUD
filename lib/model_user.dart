class ModelUser {
  int? id; //the variable name should be same as database.dart
  String email;
  String phone;

//here we asign the variable data , send as parameter
  ModelUser({
    required this.id,
    required this.email,
    required this.phone,
  });

  // factory ModelUser.fromMap(Map<String, dynamic> json)=> ModelUser(
//       id: json["id"],
//       email: json["email"],
//       phone: json["phone"],
//     );

  // void myFucn(String json) {
  //   print(json);
  // }
//json is a name. we can chnge to other names also
//fromMap is user defined name, we pass Map as parameter to get ModelUser
// ### this constructor return in model class since we send data as Map to database now we have convert Mao to model
  factory ModelUser.fromMap(Map<String, dynamic> json) {
    return ModelUser(
      id: json["id"],
      email: json["email"],
      phone: json["phone"],
    );
  }

  // Map<String, dynamic> toMap() { //example
  //   Map<String, dynamic> x = {};
  //   x['email'] = email;
  //   x['phone'] = phone;
  // }

//## here we send the data to database as Map. we convert data to map
  Map<String, dynamic> toMap() => {
        //"id" : id,
        "email": email,
        "phone": phone,
      };
}
