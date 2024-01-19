import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RateOurService extends StatefulWidget {
  const RateOurService({Key? key}) : super(key: key);

  @override
  State<RateOurService> createState() => _RateOurServiceState();
}

class _RateOurServiceState extends State<RateOurService> {
  TextEditingController opinionController = TextEditingController();
  double? stars;
  @override
  void dispose() {
    opinionController.dispose();
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
                const SizedBox(height: 90),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Center(
                      child: RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          stars = rating;
                        },
                      ),
                    )),
                const SizedBox(height: 150),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: opinionController,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Describe your opinion",
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                InkWell(
                  onTap: () async {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Review Saved')));
                    await FirebaseFirestore.instance.collection('Reviews').add({
                      'rating': stars ?? 5,
                      'opinion': opinionController.text
                    });
                    Get.back();
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
