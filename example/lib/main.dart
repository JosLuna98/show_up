import 'package:flutter/material.dart';
import 'package:show_up/show_up.dart';

void main() {
  runApp(MaterialApp(
    home: WrapUp(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Notice'),
              onPressed: () {
                ShowUp().notice(
                  backgroundColor: Colors.red,
                  text: 'notification',
                  color: Colors.white,
                  icon: Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                  sector: Sector.topRight,
                  toolbar: true,
                );
              },
            ),
            ElevatedButton(
              child: Text('Sectorized'),
              onPressed: () {
                ShowUp().sectorized(
                  child: AnimatedFlutterLogo(),
                  sector: Sector.bottomLeft,
                  toolbar: true,
                );
              },
            ),
            ElevatedButton(
              child: Text('Positioned'),
              onPressed: () {
                ShowUp().positioned(
                  child: AnimatedFlutterLogo(),
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  top: MediaQuery.of(context).size.height / 2 - 20,
                );
              },
            ),
            ElevatedButton(
              child: Text('Screen'),
              onPressed: () {
                ShowUp().screen(
                  child: Container(
                    color: Colors.green[500],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedFlutterLogo(),
                          ElevatedButton(
                            child: Text('Close'),
                            onPressed: () => ShowUp().cleanOverlay(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedFlutterLogo extends StatefulWidget {
  AnimatedFlutterLogo();

  @override
  _AnimatedFlutterLogoState createState() => _AnimatedFlutterLogoState();
}

class _AnimatedFlutterLogoState extends State<AnimatedFlutterLogo> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.yellow,
      duration: Duration(milliseconds: 800),
      height: _isOpen ? 120 : 50,
      width: _isOpen ? 120 : 50,
      child: GestureDetector(
        child: FlutterLogo(size: _isOpen ? 80 : 50),
        onTap: () => setState(() => _isOpen = !_isOpen),
      ),
    );
  }
}
