import 'package:flutter/material.dart';

import '../home/HomePage.dart';
import 'Services.dart';
import '../requests/myRequests.dart';

class ServiceScreen extends StatefulWidget {
  static const String routeName = "/service_screen";

  final int initialTab;

  const ServiceScreen({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _title;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    _title = widget.initialTab == 0 ? "Services" : "My Requests";

    _tabController.addListener(_updateTitle);
  }

  void _updateTitle() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _title = _tabController.index == 0 ? "Services" : "My Requests";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Theme.of(context).textTheme.bodyLarge),
        leading: BackButton(
          onPressed: () =>
              Navigator.popAndPushNamed(context, HomePage.routeName),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          tabs: const [
            Tab(text: "Services"),
            Tab(text: "My Requests"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Services(),
          MyRequests(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateTitle);
    _tabController.dispose();
    super.dispose();
  }
}
