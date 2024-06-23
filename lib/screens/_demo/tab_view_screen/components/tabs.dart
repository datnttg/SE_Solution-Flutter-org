import 'package:flutter/material.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => FirstTabState();
}

class FirstTabState extends State<FirstTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 50.0,
            child: new TabBar(
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              tabs: [
                Tab(
                  text: "ONE",
                ),
                Tab(
                  text: "TWO",
                ),
                Tab(
                  text: "THREE",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Text("TAB ONE CONTENT"),
            Text("TAB TWO CONTENT"),
            Text("TAB THREE CONTENT"),
          ],
        ),
      ),
    );
  }
}
