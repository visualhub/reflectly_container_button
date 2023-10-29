import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool isTrue = false;
  late AnimationController animationController;
  bool animation = true;
  void isChecked() {
    setState(
      () {
        if (isTrue) {
          Future.delayed(
            const Duration(milliseconds: 200),
            () {
              setState(() {
                isTrue = false;
              });
            },
          );
        } else {
          isTrue = true;
        }
      },
    );
  }

  void animateIcon() {
    setState(() {
      animation ? animationController.forward() : animationController.reverse();
      animation = !animation;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      reverseDuration: const Duration(
        milliseconds: 200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 193.61111111111111,
            width: 170,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      isChecked();
                      animateIcon();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 170 / 3,
                      width: 170 / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber),
                      child: const Hero(
                        tag: 'HeroButton',
                        child: ImageIcon(
                          AssetImage("assets/plus.png"),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                if (isTrue)
                  FadeInUp(
                    from: 0,
                    duration: const Duration(milliseconds: 100),
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 193.61111111111111,
                            width: 170,
                            child: CustomContainerClipper(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              isChecked();
                              animateIcon();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 170 / 3,
                              width: 170 / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent),
                              child: RotationTransition(
                                turns: Tween(begin: 0.0, end: 0.38)
                                    .animate(animationController),
                                child: const ImageIcon(
                                  AssetImage("assets/plus.png"),
                                  color: Colors.white,
                                  size: 20,
                                ),
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
        ),
      ),
    );
  }
}

class CustomContainerClipper extends StatelessWidget {
  const CustomContainerClipper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipCliper(),
      child: Container(
        height: 193.61111111111111,
        width: 170,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Colors.amber, Color.fromARGB(255, 190, 118, 202)]),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class ClipCliper extends CustomClipper<Path> {
  @override
  Path getClip(size) {
    double curve = size.width / 8;
    double smallCurve = size.width / 10;
    double difference = (size.width / 3) / 2;
    double height = (size.width + difference / 5) - difference;
    double totalHeight = size.width + difference / 1.2;
    double width = size.width;
    // print(curve);
    // print(difference);
    // print(width);
    // print("height$height");
    // print(totalHeight);

    Path path = Path();
    //Point(a)
    path.lineTo(0, 0);
    //Point(b)
    path.lineTo(0, height - curve);
    path.quadraticBezierTo(0, height, 0 + curve, height);
    //Point(c)
    path.lineTo((width / 3) - smallCurve, height);
    path.quadraticBezierTo(
        (width / 3), height, (width / 3), height + smallCurve);
    //Point(d)
    path.lineTo((width / 3), totalHeight - curve);
    path.quadraticBezierTo(
        (width / 3), totalHeight, (width / 3) + curve, totalHeight);
    //Point(e)
    path.lineTo((width - (width / 3)) - curve, totalHeight);
    path.quadraticBezierTo(width - (width / 3), totalHeight,
        width - (width / 3), totalHeight - curve);
    //Point(f)
    path.lineTo(width - (width / 3), height + smallCurve);
    path.quadraticBezierTo(
        width - (width / 3), height, width - (width / 3) + smallCurve, height);
    //Point(g)
    path.lineTo(width - curve, height);
    path.quadraticBezierTo(width, height, width, height - curve);
    //Point(h)
    path.lineTo(width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
