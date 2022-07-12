import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_final/reusable_card.dart';
import 'package:flutter_task_final/second_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'constatnts.dart';
import 'icon_content.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/e-commerce-379cf.appspot.com/o/3.png?alt=media&token=75339fcc-b543-47a3-aa6c-de6f3dba434b',
  'https://firebasestorage.googleapis.com/v0/b/e-commerce-379cf.appspot.com/o/2.png?alt=media&token=4592e9c5-4416-40c9-9d01-d3afa385a1cd',
  'https://firebasestorage.googleapis.com/v0/b/e-commerce-379cf.appspot.com/o/1.png?alt=media&token=f953fecd-b652-476d-a4a1-4c5a9497b5ca',
  'https://firebasestorage.googleapis.com/v0/b/e-commerce-379cf.appspot.com/o/4.png?alt=media&token=e6d29457-7c6a-4fa2-9a3c-1e3a62ae58c6',
];
enum Gender {
  male,
  female,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Modeling App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Modeling App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  late Gender selectedGender;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    selectedGender = Gender.male;
    super.initState();
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.contain, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: const Text(
                          'T-Shirt',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Flutter Modeling Task"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.male;
                              });
                            },
                            colour: selectedGender == Gender.male
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            cardChild: IconContent(
                              icon: FontAwesomeIcons.mars,
                              label: 'MALE',
                            ),
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.female;
                              });
                            },
                            colour: selectedGender == Gender.female
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            cardChild: IconContent(
                              icon: FontAwesomeIcons.venus,
                              label: 'FEMALE',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: imageSliders,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: Colors.amber[800],
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage();
                  }),
              MaterialButton(
                  color: Colors.amber[800],
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImageC();
                  }),
              const SizedBox(
                height: 20,
              ),
              image != null
                  ? Image.file(image!)
                  : const Text("No image selected"),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  elevation: 18.0,
                  color: Colors.amber[800],
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondScreen(),
                          ));
                    },
                    child: const Text("Next"),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
