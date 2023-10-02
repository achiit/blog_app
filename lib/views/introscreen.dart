import 'package:blog_app/views/blog_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 630,
            width: double.infinity,
            color: Color(0xffa3d4ff),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Image.asset(
                  "assets/8033205.jpg",
                  height: 400,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: BlogListScreen(),
                              );
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        fixedSize: Size(230, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: Text(
                        "Read More",
                        style: GoogleFonts.poppins(fontSize: 20),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Blog App",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text("Explore Endless Stories, One Blog at a Time",
                    style: GoogleFonts.poppins(fontSize: 15)),
                Text(
                    "Discover a world of knowledge, inspiration, and creativity with our blog app. Dive into a tapestry of ideas and experiences from across the globe.",
                    style: GoogleFonts.poppins(fontSize: 15))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
