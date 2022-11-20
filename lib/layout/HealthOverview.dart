import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_dashboard/res/ecg_data.dart';
import 'package:health_dashboard/widgets/CircularProgress.dart';
import 'package:health_dashboard/widgets/graph.dart';
import 'package:intl/intl.dart';

class HealthOverview extends StatefulWidget {
  final double systole;
  final double diastole;
  final double pulse;
  final double ammonia;
  final double acetone;
  final double Function() ecgGraphValue;
  const HealthOverview({
    Key? key,
    required this.systole,
    required this.diastole,
    required this.pulse,
    required this.ammonia,
    required this.acetone,
    required this.ecgGraphValue,
  }) : super(key: key);

  @override
  State<HealthOverview> createState() => _HealthOverviewState();
}

class _HealthOverviewState extends State<HealthOverview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(color: Color(0xFFFFFCF8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Health Overview",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              DateFormat("MMMM, dd, yyyy").format(DateTime.now()).toString(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
              height: 300,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Color(0xFF303030)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFD0FBFF)),
                        child: Image.asset("assets/BP.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Blood\nPressure",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFD0FBFF)),
                        child: Text(
                          "NORMAL",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularProgressWithContainer(
                        value: widget.systole,
                        unit: "mmHg",
                        width: 120,
                        height: 120,
                        title: "SYSTOLE",
                      ),
                      CircularProgressWithContainer(
                        value: widget.diastole,
                        unit: "mmHg",
                        width: 120,
                        height: 120,
                        title: "DIASTOLE",
                      ),
                      CircularProgressWithContainer(
                        value: widget.pulse,
                        unit: "mmHg",
                        width: 120,
                        height: 120,
                        title: "BPM",
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                DiseaseContainer(
                  img: "assets/heart.png",
                  headTitle: "DIABETICS",
                  title: "ACETONE",
                  val: widget.acetone,
                ),
                SizedBox(
                  width: 50,
                ),
                DiseaseContainer(
                  img: "assets/heart.png",
                  headTitle: "RENAL",
                  title: "AMMONIA",
                  val: widget.ammonia,
                ),
              ],
            ),
            EcgGraph(
              color: Colors.black,
              ecgValue: widget.ecgGraphValue,
            ),
          ],
        ),
      ),
    );
  }
}

class DiseaseContainer extends StatelessWidget {
  final String img;
  final String headTitle;
  final String title;
  final double val;
  const DiseaseContainer({
    Key? key,
    required this.img,
    required this.headTitle,
    required this.title,
    required this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFBF0F3), width: 2),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFFBF0F3),
                ),
                child: Image.asset(img),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                headTitle,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "  " + title + " : ",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                val.toString(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              Text(
                " ppm",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xFF818181),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFFBF0F3)),
            child: Text(
              "NORMAL",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
