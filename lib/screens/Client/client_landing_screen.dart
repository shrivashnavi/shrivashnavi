import 'package:cehpoint_project_management/Controllers/splash.dart';
import 'package:cehpoint_project_management/screens/Authentication/login_screen.dart';

import 'package:cehpoint_project_management/screens/Client/feedback.dart';
import 'package:cehpoint_project_management/screens/Client/rate_our_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientLandingScreen extends StatefulWidget {
  const ClientLandingScreen({Key? key, required this.projectName})
      : super(key: key);
  final String projectName;
  @override
  State<ClientLandingScreen> createState() => _ClientLandingScreenState();
}

class _ClientLandingScreenState extends State<ClientLandingScreen> {
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final namesData = FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectName)
        .get();

    return FutureBuilder(
      future: namesData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splash();
        }

        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              // color: Colors.greenAccent,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  // AppBar
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/mobile.png",
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                        ),
                        IconButton(
                            onPressed: () => Get.offAll(const LoginScreen()),
                            icon: const Icon(Icons.exit_to_app))
                      ],
                    ),
                  ),

                  //My Project with color background
                  Container(
                    color: const Color(0xffF8EF95),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.cyanAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Center(
                            child: Icon(
                              Icons.article_outlined,
                              size: 30,
                              color: Color(0xff999999),
                            ),
                          ),
                        ),
                        Text(
                          snapshot.data!['project-name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  // Manager Details
                  Container(
                    height: 180,
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            //Name of project manager
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      snapshot.data!['client-name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Company name
                            SizedBox(
                              // color: Colors.greenAccent,
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.domain,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      snapshot.data!['company-name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Contact number of project manager
                            SizedBox(
                              // color: Colors.greenAccent,
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.call,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      snapshot.data!['phone'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Date start and end of project
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.date_range_outlined,
                                      size: 30,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      "${snapshot.data!['start-date']} to ${snapshot.data!['end-date']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Project Name
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Weekly Report
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffCCCCCC),
                        ),
                        top: BorderSide(
                          color: Color(0xffCCCCCC),
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "WEEKLY REPORT",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // All Weeks Report List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        var isPresent =
                            snapshot.data!['week-${index + 1}'] == 'null'
                                ? false
                                : true;
                        var urlBool = isPresent
                            ? snapshot.data!['week-${index + 1}']
                            : 'null';
                        final Uri url = Uri.parse(urlBool);
                        if (isPresent) {
                          return Column(
                            children: [
                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.antiAlias,
                                margin: EdgeInsets.zero,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffD4C00B),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      topLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: ExpansionTile(
                                    initiallyExpanded: false,
                                    title: Text(
                                      'Week-${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    children: [
                                      //Project name and feedback
                                      Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            // MY Project
                                            SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.article_outlined,
                                                    size: 30,
                                                    color: Color(0xff999999),
                                                  ),
                                                  const SizedBox(
                                                    width: 13,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      snapshot.data![
                                                          'project-name'],
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //UPDATE REPORT
                                            InkWell(
                                              onTap: isPresent
                                                  ? () {
                                                      _launchUrl(url);
                                                    }
                                                  : () {},
                                              child: SizedBox(
                                                height: 40,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.link,
                                                      size: 30,
                                                      color: isPresent
                                                          ? Colors.blue
                                                          : Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 13,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        "View Report",
                                                        style: TextStyle(
                                                          color: isPresent
                                                              ? Colors.blue
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          color: Colors.white, height: 18),

                                      //View FeedBack
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => FeedbackForm(
                                                weekNo: index + 1,
                                                clientProjectName: snapshot
                                                    .data!['project-name'],
                                              ));
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          color: Colors.white,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff4A4A4A),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.message_outlined,
                                                  size: 23,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 13,
                                                ),
                                                Text(
                                                  'Submit Feedback',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        } else {
                          return const SizedBox(
                            height: 10,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => const RateOurService());
            },
            backgroundColor: const Color(0xff66CA43),
            label: const Text(
              "RATE OUR SERVICE",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            icon: const Icon(
              Icons.star,
              color: Color(0xffFFE555),
            ),
            // child: const Icon(Icons.navigation),
          ),
        );
      },
    );
  }
}
