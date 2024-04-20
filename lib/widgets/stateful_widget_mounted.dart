import 'package:flutter/widgets.dart';

class StatefulWidgetMounted extends StatefulWidget {
  const StatefulWidgetMounted({Key? key}) : super(key: key);

  @override
  StatefulWidgetMountedState createState() => StatefulWidgetMountedState();
}

class StatefulWidgetMountedState<T extends StatefulWidgetMounted> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}