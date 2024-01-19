import 'package:cehpoint_project_management/Controllers/project_list.dart';
import 'package:cehpoint_project_management/Controllers/splash.dart';
import 'package:cehpoint_project_management/screens/Authentication/login_screen.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/add_project.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/add_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class ProjectManagerLandingScreen extends StatefulWidget {
  const ProjectManagerLandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectManagerLandingScreen> createState() =>
      _ProjectManagerLandingScreenState();
}

class _ProjectManagerLandingScreenState
    extends State<ProjectManagerLandingScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    showAlertDialog(BuildContext context, int index) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Get.back();
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Continue"),
        onPressed: () async {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Project Deleted'),
            ),
          );
          final dbP = FirebaseFirestore.instance
              .collection('projects')
              .doc(ProjectNamesList.projectNames[index]);
          final data = await dbP.get();
          final user = data['username'];
          final dbU = FirebaseFirestore.instance.collection('users').doc(user);
          await dbU.delete().then(
                (doc) => print("Document deleted"),
                onError: (e) => print("Error updating document $e"),
              );

          await dbP.delete().then(
                (doc) => print("Document deleted"),
                onError: (e) => print("Error updating document $e"),
              );

          ProjectNamesList.removeName(ProjectNamesList.projectNames[index]);
          UsernameList.removeName(user);
          Get.back();
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        content: const Text("Are you sure you want to Delete?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return FutureBuilder(
      future: ProjectNamesList.getList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splash();
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/mobile.png",
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ProjectNamesList.getList();
                                        print('done');
                                      });
                                    },
                                    icon: const Icon(Icons.refresh)),
                              ),
                              Expanded(
                                child: PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      const PopupMenuItem<int>(
                                        value: 0,
                                        child: Text("Add Project"),
                                      ),
                                      const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text("Log Out"),
                                      ),
                                    ];
                                  },
                                  onSelected: (value) {
                                    if (value == 0) {
                                      Get.to(() => const AddProject());
                                    }
                                    if (value == 1) {
                                      Get.offAll(const LoginScreen());
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //ano
                  const SizedBox(height: 10),
                  //AddProject Button
                  TextButton(
                    onPressed: () {
                      Get.to(() => const AddProject());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffD4C00B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
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
                            'ADD PROJECT',
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
                  const SizedBox(height: 30),
                  // Tab Bar
                  TabBar(
                    indicatorColor: const Color(0xffD4C00B),
                    controller: tabController,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 50),
                    tabs: const [
                      Tab(
                        child: Text(
                          "Projects",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Report",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        if (ProjectNamesList.projectNames.isEmpty)
                          const Center(
                            child: Text('No Projects(Try Refreshing)'),
                          ),
                        if (ProjectNamesList.projectNames.isEmpty)
                          const Center(
                            child: Text('No Reports(Try Refreshing)'),
                          ),

                        if (ProjectNamesList.projectNames.isNotEmpty)
                          ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: ProjectNamesList.projectNames.length,
                            itemBuilder: (context, index) {
                              print(ProjectNamesList.projectNames);

                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffCCCCCC),
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Icon(
                                              Icons.article_outlined,
                                              color: Color(0xff818181),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                170,
                                            child: Text(
                                              ProjectNamesList
                                                  .projectNames[index],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showAlertDialog(context, index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffD4C00B),
                                        ),
                                        child: Text(
                                          'DELETE',
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        //TASK
                        if (ProjectNamesList.projectNames.isNotEmpty)
                          ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: ProjectNamesList.projectNames.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffCCCCCC),
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          140,
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Icon(
                                              Icons.article_outlined,
                                              color: Color(0xff818181),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                190,
                                            child: Text(
                                              ProjectNamesList
                                                  .projectNames[index],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => AddReport(
                                                clientProjectName:
                                                    ProjectNamesList
                                                        .projectNames[index],
                                              ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffD4C00B),
                                        ),
                                        child: Text(
                                          'ADD REPORT',
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
