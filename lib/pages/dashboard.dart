import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_dashboard/layout/HealthOverview.dart';
import 'package:health_dashboard/layout/SideBar.dart';
import 'package:health_dashboard/layout/VitalMeasurements.dart';
import 'package:health_dashboard/res/ecg_data.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Map bpRef = {"systole": 0, "diastole": 0, "pulse": 0};
  Map bmiRef = {};
  Map vitalRef = {};
  Map diabeticRef = {"Ammonia": 0, "Acetone": 0};
  double systole = 0;
  double diastole = 0;
  double pulse = 0;
  double ammonia = 0;
  double acetone = 0;
  double height = 0;
  double weight = 0;
  double spo2 = 0;
  double roomTemp = 0;
  double bodyTemp = 0;
  double bmi = 0;
  // ECG GRAPH
  int n = -1;
  bool initiated = false;

  double ecgValue() {
    if (n < 75 && initiated) {
      n++;
      return ecgDataList[n];
    } else if (initiated) {
      n = 0;
      return ecgDataList[n];
    } else {
      return 0;
    }
  }

  void calculateBMI(double height, double weight) {
    double heightInM = height / 100;
    double heightSquare = heightInM * heightInM;
    double result = weight / heightSquare;
    setState(() {
      bmi = result;
    });
  }

  void callAPI() async {
    try {
      Uri baseUrl = Uri.parse('https://ust-iot-nodejs-server.vercel.app/');
      var res = await http.get(baseUrl);
      var data = jsonDecode(res.body);
      // print(data);

      if (data.length > 0) {
        setState(() {
          bpRef = data[0] as Map;
          bmiRef = data[1] as Map;
          vitalRef = data[2] as Map;
          diabeticRef = data[3] as Map;
          systole = int.parse(bpRef['systole'].replaceAll(RegExp('[^0-9]'), ''))
              .toDouble();
          diastole =
              int.parse(bpRef['diastole'].replaceAll(RegExp('[^0-9]'), ''))
                  .toDouble();
          pulse = int.parse(bpRef['pulse'].replaceAll(RegExp('[^0-9]'), ''))
              .toDouble();
          acetone = diabeticRef['Acetone'].toDouble();
          ammonia = diabeticRef['Ammonia'].toDouble();
          height = bmiRef['cm1'].toDouble();
          weight = bmiRef['weight'].toDouble();
          spo2 = vitalRef['spo2'].toDouble();
          bodyTemp = double.parse(vitalRef['bodytemp']);
          roomTemp = double.parse(vitalRef['roomtemp']);
          calculateBMI(height, weight);
          // print(weight);
          initiated = true;
        });
      } else {
        print("WAIT");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        callAPI();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SIDE BAR
          SideBar(),
          // OVERVIEW
          Expanded(
            child: HealthOverview(
              systole: systole,
              diastole: diastole,
              pulse: pulse,
              acetone: acetone,
              ammonia: ammonia,
              ecgGraphValue: ecgValue,
            ),
          ),
          // BMI and VITAL
          VitalMeasurements(
            height: height,
            weight: weight,
            spo2: spo2,
            roomTemp: roomTemp,
            bodyTemp: bodyTemp,
            bmi: bmi,
          ),
        ],
      ),
    );
  }
}
