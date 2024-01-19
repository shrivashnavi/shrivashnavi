import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/authenticationController.dart';

class ClientLogin extends StatefulWidget {
  const ClientLogin({Key? key}) : super(key: key);

  @override
  State<ClientLogin> createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {
  AuthenticationController authenticationController = Get.find();

  final secretKey = GlobalKey<FormState>();
  var hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  height: 74,
                  width: 74,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/mobile.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 55),
                Text(
                  "Log-In as Client",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 130),
                Form(
                    key: secretKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Username";
                              }
                              return null;
                            },
                            controller: authenticationController.clientUserName,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff999999),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff999999),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Password";
                              }
                              return null;
                            },
                            controller: authenticationController.clientPassword,
                            keyboardType: TextInputType.text,
                            obscureText: hidePass,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePass = !hidePass;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff999999),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff999999),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 160),
                InkWell(
                  onTap: () {
                    secretKey.currentState!.validate();
                    if (secretKey.currentState!.validate()) {
                      authenticationController.loginClient(context);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0XFFD4C00B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Log-In',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
