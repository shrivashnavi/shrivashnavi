import 'package:cehpoint_project_management/Controllers/project_list.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/project_manager_landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddEmployeeState();
}

TextEditingController clientNameController = TextEditingController();
TextEditingController projectNameController = TextEditingController();
TextEditingController startDateController = TextEditingController();
TextEditingController endDateController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController companyNameController = TextEditingController();
var clientName = '';
var projectName = '';
var startDate = '';
var endDate = '';
var phone = '';
var username = '';
var password = '';
var companyName = '';
Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class _AddEmployeeState extends State<AddProject> {
  @override
  Widget build(BuildContext context) {
    void save() async {
      clientName = clientNameController.text;
      companyName = companyNameController.text.isEmpty
          ? 'cehpoint'
          : companyNameController.text;
      projectName = projectNameController.text;
      startDate = startDateController.text;
      endDate = endDateController.text;
      phone = phoneController.text;
      username = usernameController.text;
      password = passwordController.text;

      if (clientName.isEmpty ||
          projectName.isEmpty ||
          startDate.isEmpty ||
          endDate.isEmpty ||
          phone.isEmpty ||
          username.isEmpty ||
          password.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('All Fields Required')));
        return;
      }
      if (ProjectNamesList.projectNames.contains(projectName)) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Project name exists')));
        return;
      }
      if (UsernameList.usernames.contains(username)) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Username exists')));
        return;
      }
      ProjectNamesList.addName(projectName);
      UsernameList.addName(username);
      Get.offAll(const ProjectManagerLandingScreen());

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Project Saved')));
      FocusManager.instance.primaryFocus?.unfocus();

      final Uri whatsappUrl = Uri.parse(
          "whatsapp://send?phone=+91 ${phoneController.text}"
          "&text=${Uri.encodeComponent('Hi sir please login your account to check project progress :-\nUserId- ${usernameController.text}\nPassword- ${passwordController.text}')}");

      _launchUrl(whatsappUrl);

      clientNameController.clear();
      companyNameController.clear();
      passwordController.clear();
      phoneController.clear();
      usernameController.clear();
      startDateController.clear();
      endDateController.clear();
      projectNameController.clear();

      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectName)
          .set({
        'client-name': clientName,
        'company-name': companyName,
        'project-name': projectName,
        'start-date': startDate,
        'end-date': endDate,
        'phone': phone,
        'username': username,
        'password': password,
        'week-1': 'null',
        'week-2': 'null',
        'week-3': 'null',
        'week-4': 'null',
        'week-5': 'null',
        'week-1-feedback': 'Not Available',
        'week-2-feedback': 'Not Available',
        'week-3-feedback': 'Not Available',
        'week-4-feedback': 'Not Available',
        'week-5-feedback': 'Not Available',
      });
      await FirebaseFirestore.instance.collection('users').doc(username).set({
        'password': password,
        'project-name': projectName,
      });
    }

    void datePicker(TextEditingController controller) {
      showDatePicker(
        //*returns future type data
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2026),
      ).then((date) {
        //*programs do not stop and keep executing but when date is entered this 'then' function is called by flutter and picked date argument is passed by flutter
        if (date == null) {
          return;
        }
        print(date);
        setState(() {
          controller.text = DateFormat.yMd().format(date);
        });
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // AppBar
                Container(
                  height: AppBar().preferredSize.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "ADD PROJECT",
                          textAlign: TextAlign.center,
                          // textDirection: TextDirection.LTR,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            const Text(
                              "Project Details",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xffD4C00B),
                              ),
                            ),
                            const SizedBox(height: 40),
                            //input fields
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: const Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      controller: clientNameController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "CLIENT NAME",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: const Icon(
                                      Icons.domain,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      controller: companyNameController,
                                      // controller: _firstNameController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "COMPANY NAME",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Project Name
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: const Icon(
                                      Icons.article_outlined,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      controller: projectNameController,
                                      // controller: _firstNameController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "PROJECT NAME",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Project Starting Date
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: const Icon(
                                      Icons.date_range_outlined,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      onTap: () =>
                                          datePicker(startDateController),
                                      controller: startDateController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "PROJECT STARTING DATE",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Project End Date
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: const Icon(
                                      Icons.date_range_outlined,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      onTap: () =>
                                          datePicker(endDateController),
                                      controller: endDateController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "PROJECT END DATE",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Phone Number Input
                            SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: const Icon(
                                        Icons.call,
                                        size: 30,
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneController,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: "PHONE NUMBER",
                                          hintStyle: TextStyle(
                                            color: Color(0xff999999),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 30),

                            // EMPLOYEE USER NAME
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      // color: Colors.greenAccent,
                                      height: 10,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: const Icon(
                                        Icons.how_to_reg_sharp,
                                        size: 30,
                                        color: Color(0xff999999),
                                      )),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      controller: usernameController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "USER NAME",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Password
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: const Icon(
                                      Icons.password_outlined,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0XFF00c39A),
                                          ),
                                        ),
                                        hintText: "PASSWORD",
                                        hintStyle: TextStyle(
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // BUTTON ADD EMPLOYEE
                        InkWell(
                          onTap: save,
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0XFFD4C00B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'SAVE PROJECT',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
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
