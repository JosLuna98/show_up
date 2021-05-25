# Show Up

A Flutter plugin to easily display and remove overlapping widgets anywhere in the application.

```yaml
environment:
  sdk: ">=2.12.0 <3.0.0"
  flutter: ">=1.20.0"
```

## Getting Started

To use this plugin, add `show_up` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  show_up: ^1.0.0
```

## Usage

Import the package:
```dart
import 'package:show_up/show_up.dart';
```

Wrap the child widgets of MaterialApp where `Show Up` widgets.
```dart
void main() {
  runApp(MaterialApp(
    home: WrapUp(child: MyApp()),
  ));
}
```

### Notice
Shows a default notification positioned by Sector.

```dart
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
)
```

### Sectorized
Shows a widget positioned by Sector.

```dart
ElevatedButton(
  child: Text('Sectorized'),
  onPressed: () {
    ShowUp().sectorized(
      child: AnimatedFlutterLogo(),
      sector: Sector.bottomLeft,
      toolbar: true,
    );
  },
)
```

### Positioned
Shows a widget positioned by LTRB params.

```dart
ElevatedButton(
  child: Text('Positioned'),
  onPressed: () {
    ShowUp().positioned(
      child: AnimatedFlutterLogo(),
      left: MediaQuery.of(context).size.width / 2 - 20,
      top: MediaQuery.of(context).size.height / 2 - 20,
    ;
  },
)
```

### Screen
Shows an overlayed screen.

```dart
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
)
```

##  License

MIT License
