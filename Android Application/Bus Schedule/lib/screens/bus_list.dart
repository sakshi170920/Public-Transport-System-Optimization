import 'package:flutter/cupertino.dart';
import 'package:busoptimizer/helpers/shared_prefs.dart';

class BusListView extends StatefulWidget {
  static const String id = "BusListViewScreen";
  const BusListView({Key? key}) : super(key: key);

  @override
  State<BusListView> createState() => _BusListViewState();
}

class _BusListViewState extends State<BusListView> {
  late String source;
  late String destination;
  @override
  void initState() {
    super.initState();
    source = getSourceAndDestination('source');
    destination = getSourceAndDestination('destination');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("let's go from $source  =>  $destination"),
    );
  }
}
