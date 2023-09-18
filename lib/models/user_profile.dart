
class UserProfile{
  final String? age, numberPhone, mssv, lop;
  final bool gender;

  UserProfile({this.age, this.numberPhone, this.mssv, this.lop, this.gender = true});

  UserProfile.fromJson(Map<String, Object?> json):this(
      age: json['age']! as String,
      numberPhone: json['phone']! as String,
      mssv: json['mssv']! as String,
      lop: json['lop']! as String,
      gender: json['gender']! as bool
  );

  Map<String, Object?> toJson() {
    return {
      'age': age,
      'phone': numberPhone,
      'mssv': mssv,
      'lop': lop,
      'gender': gender,
    };
  }

}

// UserProfile currentUserProfile = UserProfile(age: "22", numberPhone: "0842427891", mssv: "B1910362", lop: "DI19V7A4", gender: true);