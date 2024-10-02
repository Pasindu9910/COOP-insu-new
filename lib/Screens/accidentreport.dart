// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // To make phone calls

class AccidentReport extends StatefulWidget {
  const AccidentReport({super.key});

  @override
  State<AccidentReport> createState() => _AccidentReportState();
}

class _AccidentReportState extends State<AccidentReport>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Repeat animation in reverse direction

    // Define the animation as a scaling effect between 0.95 and 1.05
    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the animation controller to free resources
    super.dispose();
  }

  // Function to make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Accident Report',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Georgia',
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 0, 68, 124),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add the text above the buttons
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0), // Add some space between the text and the buttons
                    child: Text(
                      'Click to get connected with call center',
                      style: TextStyle(
                        color: Colors.white, // White font color
                        fontSize: 20, // Font size of 20px
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                  ),
                  
                  // First button with pulsing image
                  ScaleTransition(
                    scale: _animation,
                    child: InkWell(
                      onTap: () => _makePhoneCall('0117440033'),
                      child: Image.asset(
                        'assets/callus.png', // Add your image here
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Second button with pulsing image
                  ScaleTransition(
                    scale: _animation,
                    child: InkWell(
                      onTap: () => _makePhoneCall('0112440033'),
                      child: Image.asset(
                        'assets/callus.png', // Add your image here
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Space between the call buttons and the onsite button
                  // Onsite Inspections button
                  SizedBox(
                    width: 250,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.purple, // Set the button color to purple
                        elevation: 10,
                        shadowColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/onsite');
                      },
                      child: const Text(
                        'Onsite Inspections',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
