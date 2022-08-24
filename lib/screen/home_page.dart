import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);

    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 100.0, end: 300.0).animate(curve);
    animation.addStatusListener(listenerStatus);
    controller.forward();
  }

  void listenerStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  Widget builderAnimation(BuildContext context, Widget? child) {
    return SizedBox(
      height: animation.value,
      width: animation.value,
      child: const FlutterLogo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listener Animation Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: AnimatedBuilder(animation: animation, builder: builderAnimation),
        ),
      ),
    );
  }
}
