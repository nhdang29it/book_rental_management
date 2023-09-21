import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeMssv = FocusNode();
  final FocusNode _focusNodeLop = FocusNode();
  final FocusNode _focusNodeTuoi = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerMssv = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword = TextEditingController();
  final TextEditingController _controllerLop = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerTuoi = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool gender = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Đăng kí",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Tạo tài khoản của bạn",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 45),
              TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "UserName",
                  prefixIcon: const Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập tên";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeMssv.requestFocus(),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                      'Giới tính: ',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Radio(
                      value: true,
                      groupValue: gender,
                      onChanged: (value){
                        if(value != null){
                          setState(() {
                            gender = value;
                          });
                        }
                      }
                  ),
                  const Text("nam"),
                  Radio(
                      value: false,
                      groupValue: gender,
                      onChanged: (value){
                        if(value != null){
                          setState(() {
                            gender = value;
                          });
                        }
                      }
                  ),
                  const Text("nữ")
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _controllerMssv,
                focusNode: _focusNodeMssv,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "MSSV",
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mã số sinh viên";
                  } else if(value.length != 8){
                    return "Mã số sinh viên có 8 chữ số";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeLop.requestFocus(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _controllerLop,
                focusNode: _focusNodeLop,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Lớp",
                  prefixIcon: const Icon(Icons.class_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập lớp";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeTuoi.requestFocus(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _controllerTuoi,
                focusNode: _focusNodeTuoi,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tuổi",
                  prefixIcon: const Icon(Icons.tag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập tuổi của bạn";
                  } else if(int.parse(value).isNaN){
                    return "Vui lòng nhập vào số tuổi của bạn";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodePhone.requestFocus(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _controllerPhone,
                focusNode: _focusNodePhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  prefixIcon: const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập số điện thoại của bạn";
                  } else if(value.length < 10 && value.length > 11){
                    return "Số điện thoại không hợp lệ";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _controllerEmail,
                focusNode: _focusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "Invalid email";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodePassword.requestFocus(),
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _controllerPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mật khẩu";
                  } else if (value.length < 8) {
                    return "Mật khẩu phải có ít nhất 8 kí tự";
                  }
                  return null;
                },
                onEditingComplete: () =>
                    _focusNodeConfirmPassword.requestFocus(),
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _controllerConFirmPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodeConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Nhập lại mật khẩu",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      icon: _obscureConfirmPassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập lại mật khẩu";
                  } else if (value != _controllerPassword.text) {
                    return "Mật khẩu không đúng";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _controllerEmail.text,
                            password: _controllerPassword.text
                        ).then((userCredential) {
                          // them collection profile
                          FirebaseFirestore.instance.collection('userProfile')
                              .doc(userCredential.user!.uid)
                              .set({
                            "age": "chua co",
                            "mssv": _controllerMssv.text,
                            "lop": "chua co",
                            "phone": "chua co",
                            "gender": gender
                          });

                          userCredential.user!.updateDisplayName(_controllerUsername.text);

                        });
                        _formKey.currentState?.reset();
                      }
                    },
                    child: const Text("Đăng kí"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Đã có tài khoản?"),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Đăng nhập"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    // _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}