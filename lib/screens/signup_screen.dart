import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Crear Cuenta",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingresa nombre de usuario",
                    Icons.person_outline, false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingresa tu email", Icons.person_outline,
                    false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingresa tu contraseña", Icons.lock_outlined,
                    true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                buttonReusable(context, "ingresar", () {
                  // FirebaseAuth.instance
                  //     .createUserWithEmailAndPassword(
                  //         email: _emailTextController.text,
                  //         password: _passwordTextController.text)
                  //     .then((value) {
                  //   // ignore: avoid_print
                  //   print("Created New Account");
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const HomeScreen()));
                  // }).onError((error, stackTrace) {
                  //   // ignore: avoid_print
                  //   print("Error ${error.toString()}");
                  // });
                })
              ],
            ),
          ))),
    );
  }
}
