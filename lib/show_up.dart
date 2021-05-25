import 'dart:async';
import 'package:flutter/material.dart';

/// Widget wrapper to [ShowUp] widgets over it.
class WrapUp extends StatefulWidget {
  /// Constructor.
  const WrapUp({required this.child});

  /// The [child] contained by the [ShowUp] wrapper.
  final Widget child;

  @override
  _WrapUpState createState() => _WrapUpState();
}

class _WrapUpState extends State<WrapUp> {
  late final StreamSubscription<Widget> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ShowUp()._incoming(context);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Helps to position the widgets.
enum Sector {
  /// Refers to the bottom edge aligned with the middle of the cross axis.
  bottomCenter,

  /// Refers to the bottom edge aligned with the start side of the cross axis.
  bottomLeft,

  /// Refers to the bottom edge aligned with the end of the cross axis.
  bottomRight,

  /// Refers to the top edge aligned with the middle of the cross axis.
  topCenter,

  /// Refers to the top edge aligned with the start side of the cross axis.
  topLeft,

  /// Refers to the top edge aligned with the end of the cross axis.
  topRight,
}

/// Allows displaying widgets by an [OverlayEntry] when views are wrapped in [WrapUp].
class ShowUp {
  /// constructor.
  const ShowUp();

  static OverlayEntry? _overlayEntry;

  /// Removes the overlay entry of [ShowUp] from the main [OverLay].
  void cleanOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static StreamController<Widget> _streamController =
      StreamController<Widget>();

  StreamSubscription<Widget> _incoming(BuildContext context) =>
      _streamController.stream.listen((Widget showIt) {
        ShowUp().cleanOverlay();
        _overlayEntry = OverlayEntry(builder: (BuildContext context) => showIt);
        Overlay.of(context)?.insert(_overlayEntry!);
      });

  /// Shows a default notification positioned by [Sector].
  void notice({
    required Color backgroundColor,
    required String text,
    required Color color,
    required Icon icon,
    Sector sector = Sector.topRight,
    bool toolbar = false,
  }) =>
      _streamController.add(_AnimatedNotice(
        backgroundColor: backgroundColor,
        text: text,
        color: color,
        icon: icon,
        sector: sector,
        toolbar: toolbar,
      ));

  /// Shows a widget positioned by [Sector].
  void sectorized({
    required Widget child,
    Sector sector = Sector.topRight,
    bool toolbar = false,
  }) =>
      _streamController.add(_Sectorizer(
        sector: sector,
        toolbar: toolbar,
        child: child,
      ));

  /// Shows a widget positioned by LTRB params.
  void positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
    required Widget child,
  }) =>
      _streamController.add(Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
        child: child,
      ));

  /// Shows an overlayed screen.
  void screen({required Widget child}) => _streamController.add(child);
}

class _Sectorizer extends StatelessWidget {
  _Sectorizer({
    required this.sector,
    required this.toolbar,
    required this.child,
  });

  final Sector sector;
  final bool toolbar;
  final Widget child;

  late final double? top;
  late final double? bottom;
  late final CrossAxisAlignment crossAxisAlignment;

  void _setSector() {
    String sectorString = sector.toString();

    if (sectorString.startsWith('Sector.top')) {
      top = toolbar ? 80 : 0;
      bottom = null;
    } else {
      bottom = 0;
      top = null;
    }

    if (sectorString.endsWith('Center'))
      crossAxisAlignment = CrossAxisAlignment.center;
    else if (sectorString.endsWith('Left'))
      crossAxisAlignment = CrossAxisAlignment.start;
    else
      crossAxisAlignment = CrossAxisAlignment.end;
  }

  @override
  Widget build(BuildContext context) {
    _setSector();
    return Positioned(
      left: 0,
      top: top,
      right: 0,
      bottom: bottom,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[child],
      ),
    );
  }
}

class _AnimatedNotice extends StatefulWidget {
  const _AnimatedNotice({
    required this.backgroundColor,
    required this.text,
    required this.color,
    required this.icon,
    required this.sector,
    required this.toolbar,
  });

  final Color backgroundColor;
  final String text;
  final Color color;
  final Icon icon;
  final Sector sector;
  final bool toolbar;

  @override
  _AnimatedNoticeState createState() => _AnimatedNoticeState();
}

class _AnimatedNoticeState extends State<_AnimatedNotice> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = false;
    Future.delayed(Duration(seconds: 1), () async {
      if (mounted) {
        setState(() => _isOpen = true);
        await Future.delayed(Duration(seconds: 3), () {
          if (mounted) setState(() => _isOpen = false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Sectorizer(
      sector: widget.sector,
      toolbar: widget.toolbar,
      child: GestureDetector(
        onTap: () => setState(() => _isOpen = !_isOpen),
        onLongPress: () => ShowUp().cleanOverlay(),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: widget.backgroundColor,
            width: _isOpen ? MediaQuery.of(context).size.width : 50,
            height: 50,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _isOpen
                  ? Text(
                      widget.text,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: widget.color, fontSize: 24),
                    )
                  : widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}
