import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      height: MediaQuery.of(context).size.height,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Image.asset("assets/logo.png"),
          SizedBox(
            height: 20,
          ),
          Image.asset("assets/dashboard.png"),
        ],
      ),
    );
  }
}
