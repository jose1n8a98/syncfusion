import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_p/screens/reset_password.dart';
import 'package:syncfusion_p/screens/signup_screen.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userTextController = TextEditingController();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("012340"),
          hexStringToColor("025959"),
          hexStringToColor("027333"),
          hexStringToColor("03A63C"),
          hexStringToColor("04D939")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Ingrese el usuario", Icons.person_outline,
                    false, _userTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese la contraseña", Icons.lock_outline,
                    true, _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                buttonReusable(context, "Ingresar", () {
                  login();
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes cuenta?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Crear",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Restablecer contraseña",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }

  Future<void> login() async {
    if (_passwordTextController.text.isNotEmpty &&
        _userTextController.text.isNotEmpty) {
      // ignore: unused_local_variable
      var response = await http.post(
          Uri.parse("https://api.egm-robotics.com/EgmSystems/Auth/getAuth"),
          body: ({
            'username': _userTextController.text,
            'password': _passwordTextController.text,
            'scope': "IMS-Systems-Mk2VxYZ"
          }));
      if (response.statusCode == 200) {
        // ignore: avoid_print
        final body = jsonDecode(response.body);
        //ScaffoldMessenger.of(context)
        //.showSnackBar(SnackBar(content: Text("Token: ${body['token']}")));
        pageRoute(body['token']);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Datos Incorrectos")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Campos no permitidos")));
    }
  }

  void pageRoute(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
