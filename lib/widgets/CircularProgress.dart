import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularProgress extends StatefulWidget {
  final double value;
  final String unit;
  final double width;
  final double height;
  const CircularProgress({
    Key? key,
    required this.value,
    required this.width,
    required this.height,
    required this.unit,
  }) : super(key: key);

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: [
          RadialAxis(
            offsetUnit: GaugeSizeUnit.factor,
            // radiusFactor: 0.5,
            showTicks: false,
            showLabels: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            annotations: [
              GaugeAnnotation(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "  " + widget.value.toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      " " + widget.unit,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
            pointers: [
              RangePointer(
                value: widget.value,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CircularProgressWithContainer extends StatefulWidget {
  final String title;
  final double value;
  final String unit;
  final double width;
  final double height;
  const CircularProgressWithContainer(
      {Key? key,
      required this.value,
      required this.unit,
      required this.width,
      required this.height, required this.title})
      : super(key: key);

  @override
  State<CircularProgressWithContainer> createState() =>
      _CircularProgressWithContainerState();
}

class _CircularProgressWithContainerState
    extends State<CircularProgressWithContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: CircularProgress(
              value: widget.value,
              width: widget.width,
              height: widget.height,
              unit: widget.unit,
            ),
          )
        ],
      ),
    );
  }
}
