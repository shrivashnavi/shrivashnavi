import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm(
      {Key? key, required this.weekNo, required this.clientProjectName})
      : super(key: key);
  final int weekNo;
  final String clientProjectName;
  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController feedbackController = TextEditingController();
  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          "FEEDBACK",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 140),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: feedbackController,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Give us your feedback",
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 240),
                InkWell(
                  onTap: () async {
                    if (feedbackController.text.isEmpty) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter feedback')));
                      return;
                    }
                    Get.back();
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Feedback Saved')));
                    await FirebaseFirestore.instance
                        .collection('projects')
                        .doc(widget.clientProjectName)
                        .update({
                      'week-${widget.weekNo}-feedback': feedbackController.text
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xffD4C00B),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
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
