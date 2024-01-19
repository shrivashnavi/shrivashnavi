import 'package:cehpoint_project_management/Controllers/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginProjectManager extends StatefulWidget {
  const LoginProjectManager({Key? key}) : super(key: key);

  @override
  State<LoginProjectManager> createState() => _LoginProjectManagerState();
}

class _LoginProjectManagerState extends State<LoginProjectManager> {
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
                  "Log-In as Project Manager",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 80),
                Text(
                  "Enter your secret code",
                  style: GoogleFonts.inter(
                    color: const Color(0xff6C6969),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 90),
                Form(
                  key: secretKey,
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Secret Code";
                        }
                        return null;
                      },
                      maxLength: 4,
                      maxLines: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller:
                          authenticationController.projectManagerSecretCode,
                      keyboardType: TextInputType.number,
                      obscureText: hidePass,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10,
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
                        hintText: ". . . .",
                        hintStyle: const TextStyle(
                          fontSize: 30,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 160),
                InkWell(
                  onTap: () {
                    secretKey.currentState!.validate();
                    if (secretKey.currentState!.validate()) {
                      authenticationController.loginProjectManager();
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
