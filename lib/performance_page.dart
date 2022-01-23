import 'package:flutter/material.dart';
import 'take_picture_screen.dart';
import 'dart:async';
import 'package:camera/camera.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  bool pressed = false;

  Future<void> onPressed() async {
    pressed = true;
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    Size displaySize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'images/default_performance_page.png',
          fit: BoxFit.fill,
        ),
        Positioned(
          left: displaySize.width / 2 - 30,
          top: displaySize.height / 2 - 30,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: pressed ? Colors.red : null,
              ),
              height: 60,
              width: 60,
              duration: const Duration(milliseconds: 200),
              child: TextButton(
                onPressed: () async {
                  await onPressed();
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        WidgetsFlutterBinding.ensureInitialized();
                        return TakePictureScreen(
                          camera: firstCamera,
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOut;
                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return FadeTransition(
                          opacity: animation.drive(
                            Tween(begin: begin, end: end).chain(tween),
                          ),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text(""),
              ),
            ),
          ),
        )
      ],
    );
  }
}
