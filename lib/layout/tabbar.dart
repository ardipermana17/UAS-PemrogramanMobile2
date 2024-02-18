import 'package:flutter/material.dart';
import 'package:thiftstore2/layout/about.dart';
import 'package:thiftstore2/layout/addbarang.dart';
import 'package:thiftstore2/layout/managebarang.dart';

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thrift Store'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.add_box),
            ),
            Tab(
              icon: Icon(Icons.list),
            ),
            Tab(
              icon: Icon(Icons.local_library),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          BarangForm(),
          ManageBarang(),
          About(),
        ],
      ),
    );
  }
}
