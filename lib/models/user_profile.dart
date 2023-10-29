
class UserProfile{
  final String? age, numberPhone, mssv, lop;
  final bool gender;

  UserProfile({this.age, this.numberPhone, this.mssv, this.lop, this.gender = true});

  factory UserProfile.fromJson(Map<String, dynamic> json){
    return UserProfile(
        age: json['age'],
        numberPhone: json['phone'],
        mssv: json['mssv'],
        lop: json['lop'],
        gender: json['gender'] ?? true
    );
  }

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