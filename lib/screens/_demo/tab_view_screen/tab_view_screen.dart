import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/tabs.dart';

class TabViewScreen extends StatefulWidget {
  const TabViewScreen({super.key});

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String title = "Home";

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: TabBarView(
        children: <Widget>[
          FirstTab(),
          MyBody("Page Two"),
          MyBody("Page Three")
        ],
// if you want yo disable swiping in tab the use below code
//            physics: NeverScrollableScrollPhysics(),
        controller: tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.purple,
        child: TabBar(
          onTap: (indedx) {
            if (indedx == 0) {
              setState(() {
                title = "Home";
              });
            } else if (indedx == 1) {
              setState(() {
                title = "Tab Two";
              });
            } else if (indedx == 2) {
              setState(() {
                title = "Tab Three";
              });
            }
          },
          indicatorColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.favorite_border),
              text: "ONE",
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: "TWO",
            ),
            Tab(
              icon: Icon(Icons.add_box),
              text: "THREE",
            ),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}
