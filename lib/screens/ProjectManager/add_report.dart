import 'package:cehpoint_project_management/Controllers/splash.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/project_manager_landing_screen.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/report_details.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/weekly_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddReport extends StatefulWidget {
  const AddReport({Key? key, required this.clientProjectName})
      : super(key: key);
  final String clientProjectName;
  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  @override
  Widget build(BuildContext context) {
    void refresh() {
      setState(() {});
    }

    final namesData = FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.clientProjectName)
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
                              Get.to(() => const ProjectManagerLandingScreen());
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "ADD REPORT",
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                            onPressed: refresh, icon: const Icon(Icons.refresh))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

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
                          widget.clientProjectName,
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

                  // ADD Report
                  const SizedBox(height: 14),
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
                      "REPORT",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportDetails(
                                clientProjectName: widget.clientProjectName)),
                      );
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffD4C00B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            'ADD REPORT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

                        return isPresent
                            ? Column(
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
                                                        color:
                                                            Color(0xff999999),
                                                      ),
                                                      const SizedBox(
                                                        width: 13,
                                                      ),
                                                      SizedBox(
                                                        child: Text(
                                                          widget
                                                              .clientProjectName,
                                                          style:
                                                              const TextStyle(
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
                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReportDetails(
                                                                  clientProjectName:
                                                                      widget
                                                                          .clientProjectName,
                                                                  val: index +
                                                                      1)),
                                                    );

                                                    setState(() {});
                                                  },
                                                  child: const SizedBox(
                                                    height: 40,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.link,
                                                          size: 30,
                                                          color: Colors.blue,
                                                        ),
                                                        SizedBox(
                                                          width: 13,
                                                        ),
                                                        SizedBox(
                                                          child: Text(
                                                            "Update Report",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
                                              Get.to(() => WeeklyFeedback(
                                                    projectName: widget
                                                        .clientProjectName,
                                                  ));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 50,
                                              color: Colors.white,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff4A4A4A),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
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
                                                      Icons.feedback_outlined,
                                                      size: 23,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 13,
                                                    ),
                                                    Text(
                                                      'VIEW FEEDBACK',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                              )
                            : const SizedBox(
                                height: 40,
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
