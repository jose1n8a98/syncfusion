import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_p/screens/signin_screen.dart';

import '../models/user_model.dart';
import '../models/values_models.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../reusable_widgets/syncfusion.dart';
import '../utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String token = "";
  String? value;
  String? _myState;
  List<dynamic> usser = [];
  List<double> pott = [0.0];

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    getCred();
    _getUsers();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Menu Inicial",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.clear();
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              },
            )
          ]),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _myState,
                    icon: null,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    hint: Text("Seleccione"),
                    onChanged: (String? newValue) {
                      setState(() {
                        _myState = newValue;
                      });
                    },
                    items: usuarios?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList() ??
                        [],
                  ),
                ),

                // FormHelper.dropDownWidgetWithLabel(
                //     context,
                //     "Usuario",
                //     "Seleccione los usuarios",
                //     "",
                //     usuarios,
                //     (onChanged) {}, (onValidate) {
                //   if (onValidate == null) {
                //     return 'Seleccione un usuario';
                //   }
                //   return null;
                // },
                //     borderColor: Theme.of(context).primaryColor,
                //     borderRadius: 10),

                buttonReusable(context, "Cargar", () {
                  _getpotentiometer();
                }),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    child: graff1(0, 100, 10, 0, 50, Colors.green, 90),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: graff2(
                      0.0, 100.0, 10, 0, 50, LinearGaugeOrientation.vertical),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: graff3(0, 100, 10, 33, "Temp. °C"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: graff4(0, 100, 50, "m/s"),
                )
              ],
            ),
          ))),
    );
  }

  String selectUser = "";
  final userSelect = TextEditingController();
  final potenSelect = TextEditingController();
  List? usuarios;
  Future<List<UserIdAPI>> _getUsers() async {
    final response = await http.post(Uri.parse(
        "http://pruebas.ushops.tech/iobits-generales/api/prueba/testgetDevices"));
    List<UserIdAPI> user = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        user.add(UserIdAPI(item["_id"]));
        usser.add(item["_id"]);
        //print(item["_id"]);
      }
      return user;
    } else {
      throw Exception("Fallo la coneccion");
    }
  }

  Future<List<ValuesModel>> _getpotentiometer() async {
    final response = await http.post(
        Uri.parse(
            "http://pruebas.ushops.tech/iobits-generales/api/prueba/testgetData"),
        body: ({
          'device_id': selectUser,
        }));
    List<ValuesModel> potenc = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        potenc.add(ValuesModel(item["potenciometro"], item["date"]));
        pott.add(item["potenciometro"].toDouble());
        // ignore: avoid_print
        print(item["potenciometro"]);
      }
      return potenc;
    } else {
      throw Exception("Fallo la coneccion");
    }
  }

  // _downloadService() async {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  DropdownMenuItem<String> buildMeniItem(String usser) => DropdownMenuItem(
      value: usser,
      child: Text(usser,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
}
