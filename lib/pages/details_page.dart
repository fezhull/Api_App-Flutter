import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Details_page extends StatelessWidget {
  const Details_page({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 4, 72),
      appBar: AppBar(
        title: const Text("H e n j o S . F e n c"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ),
        ],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 133, 153),
      ),
      body: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.9,
        child: Lottie.network(
            'https://lottie.host/348f233a-59f7-4de2-a8e0-5ecdf60fa9ca/bBOze9pO5J.json'),
      ), //AppBar
    );
  }
}
