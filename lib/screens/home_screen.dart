import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:slack/models/pets.dart';
import 'package:slack/providers/pets_provider.dart';
import 'package:slack/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final provider = Provider.of<PetsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<PetsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Sign Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 244, 241, 241),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        color: Color(0xFFc5e5f3),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 25),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 25),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xffE6E6E6),
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "James Smith",
                          style: TextStyle(
                              color: Color(0xFF3b3f42),
                              fontSize: 18,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 146, 114, 8),
                              fontSize: 14,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 25),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 25),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Discover",
                          style: TextStyle(
                              color: Color(0xFF3b3f42),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        provider.search(value);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 128, 205, 188),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search!",
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  height: 1000,
                  width: 500,
                  child: provider.isLoading
                      ? getLoadingUI()
                      : provider.error.isNotEmpty
                          ? getErrorUI(provider.error)
                          : getBodyUI()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
            gap: 8,
            backgroundColor: Color(0xFFc5e5f3),
            tabBackgroundColor: Color.fromARGB(255, 82, 114, 128),
            padding: EdgeInsets.all(12),
            tabs: [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.shopping_cart, text: 'Cart'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.person, text: 'Profile'),
            ]),
      ),
    );
  }

  Widget getLoadingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(color: Colors.blue, size: 80),
          const Text(
            'Data Loading',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI() {
    final provider = Provider.of<PetsProvider>(context, listen: false);

    return Consumer(
      builder: (context, PetsProvider petsProvider, child) => ListView.builder(
          itemCount: petsProvider.serachedPets.data.length,
          itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                      petsProvider.serachedPets.data[index].petImage),
                  backgroundColor: Colors.white,
                ),
                title: Text(petsProvider.serachedPets.data[index].userName),
                trailing: petsProvider.serachedPets.data[index].isFriendly
                    ? const SizedBox()
                    : const Icon(
                        Icons.pets,
                        color: Colors.red,
                      ),
              )),
    );
  }
}
