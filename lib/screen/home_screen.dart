import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getColor(index) {
    final color = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    return color[index % color.length];
  }

  renderSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200,
      pinned: true,
      // floating: true,
      flexibleSpace: Image.asset("assets/mountains.jpg", fit: BoxFit.cover),
      title: Text("앱바"),
    );
  }

  renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          color: getColor(index),
        );
      }, childCount: 32),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),

      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //   maxCrossAxisExtent: 100,
      // ),
    );
  }

  renderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          height: 100,
          color: getColor(index),
        );
      }, childCount: 8),
    );
  }

  renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeader(
        minHeight: 75,
        maxHeight: 200,
        child: Container(
          // color: Colors.white,
          child: Center(
            child: Text("고정 헤더"),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          renderHeader(),
          renderSliverGrid(),
          renderHeader(),
          renderSliverList(),
          renderHeader(),
          renderSliverGrid(),
          renderHeader(),
          renderSliverList(),
        ],
      ),
    );
  }
}

class _SliverFixedHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  _SliverFixedHeader(
      {required this.maxHeight, required this.minHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.maxHeight;

  @override
  double get minExtent => this.minHeight;

  @override
  bool shouldRebuild(_SliverFixedHeader oldDelegate) {
    return oldDelegate.maxHeight != this.maxHeight ||
        oldDelegate.minHeight != this.minHeight ||
        oldDelegate.child != this.child;
  }
}
