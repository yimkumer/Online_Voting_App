import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'voter.dart';

class DiagonalClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - (size.height * 0.10));
    path.lineTo(size.width, size.height - (size.height * 0.18));
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DiagonalClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - (size.height * 0.18));
    path.lineTo(size.width, size.height - (size.height * 0.10));
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class VoterWalkthrough extends StatelessWidget {
  final PageController controller = PageController();
  final ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  VoterWalkthrough({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (page) {
              currentPage.value = page;
            },
            children: [
              _buildPage(
                screenSize,
                DiagonalClipper1(),
                "assets/w1.svg",
                "' Follow the instructions to cast your Vote '",
              ),
              _buildPage(
                screenSize,
                DiagonalClipper2(),
                "assets/w2.svg",
                "' Scroll to view the available Candidate Posts -> '",
              ),
              _buildPage(
                screenSize,
                DiagonalClipper1(),
                "assets/w3.svg",
                "' Go through the list of Candidates '",
              ),
              _buildPage(
                screenSize,
                DiagonalClipper2(),
                "assets/w4.svg",
                "' You can Vote for only One candidate per Position and it is Final '",
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.02,
            right: screenWidth * 0.02,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Voter()),
                );
              },
              child: const Text(
                "SKIP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.195,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: currentPage,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value >= index
                                ? Colors.blue
                                : const Color(0xffD9D9D9),
                          ),
                        );
                      }),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.06),
                ValueListenableBuilder<int>(
                  valueListenable: currentPage,
                  builder: (context, value, child) {
                    return OutlinedButton(
                      onPressed: () {
                        if (value < 3) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Voter()),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        value < 3 ? "NEXT" : "GET STARTED",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(Size screenSize, CustomClipper<Path> clipper,
      String imagePath, String text) {
    return Stack(
      children: [
        ClipPath(
          clipper: clipper,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff030034),
                  Color(0xFF040040),
                  Color(0xFF06005D),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: screenSize.height * 0.105,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SvgPicture.asset(
                      imagePath,
                      width: screenSize.width * 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.38,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
