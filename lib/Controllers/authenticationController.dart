import 'package:cehpoint_project_management/Controllers/project_list.dart';
import 'package:cehpoint_project_management/screens/Client/client_landing_screen.dart';
import 'package:cehpoint_project_management/screens/ProjectManager/project_manager_landing_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  TextEditingController projectManagerSecretCode = TextEditingController();
  TextEditingController clientUserName = TextEditingController();
  TextEditingController clientPassword = TextEditingController();

  loginProjectManager() {
    if (projectManagerSecretCode.text == "1234") {
      projectManagerSecretCode.clear();
      Get.offAll(() => const ProjectManagerLandingScreen());
    }
  }

  loginClient(BuildContext context) async {
    try {
      print(ProjectNamesList.projectNames);
      final usersData = await FirebaseFirestore.instance
          .collection('users')
          .doc(clientUserName.text)
          .get();

      print(ProjectNamesList.projectNames);
      if (usersData.data()!['password'] == clientPassword.text &&
          ProjectNamesList.projectNames
              .contains(usersData.data()!['project-name'])) {
        // print(usersData.data()!['project-name']);
        Get.offAll(() => ClientLandingScreen(
            projectName: usersData.data()!['project-name']));
      } else {
        print(ProjectNamesList.projectNames);

        throw Exception('Invalid Credentials');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Credentials')));
    }
  }
}
