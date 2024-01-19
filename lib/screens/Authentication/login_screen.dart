import 'package:cehpoint_project_management/screens/Authentication/Client/client_login.dart';
import 'package:cehpoint_project_management/screens/Authentication/ProjectManager/login_project_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(35),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Container(
                height: 112,
                width: 117,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/mobile.png"),
                )),
              ),
              const SizedBox(height: 90),
              //LOGIN AS PROJECT MANAGER
              InkWell(
                onTap: () {
                  Get.to(() => const LoginProjectManager());
                },
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width - 70,
                  decoration: BoxDecoration(
                    color: const Color(0XFFD4C00B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.manage_accounts,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Log-in as Project Manager',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 39),
              Text(
                "OR",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 39),
              //LOGIN AS CLIENT FINAL
              InkWell(
                onTap: () {
                  Get.to(() => const LoginProjectManager());
                },
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width - 70,
                  decoration: BoxDecoration(
                    color: const Color(0XFFD4C00B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      const SizedBox(
                        height: 28,
                        width: 28,
                        child: Icon(
                          Icons.manage_accounts,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ClientLogin());
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 144,
                          child: Center(
                            child: Text(
                              'Log-in as Client',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
