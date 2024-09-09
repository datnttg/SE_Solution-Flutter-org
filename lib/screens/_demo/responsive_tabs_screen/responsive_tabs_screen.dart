import 'package:flutter/material.dart';
import '../../../utilities/constants/dismention_contants.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import 'components/overview_body.dart';
import 'components/remuneration_body.dart';
import 'components/app_menu.dart';
import 'components/customers_body.dart';

class ResponsiveTabsScreen extends StatefulWidget {
  const ResponsiveTabsScreen({super.key});

  @override
  State<ResponsiveTabsScreen> createState() => _ResponsiveTabsScreenState();
}

class _ResponsiveTabsScreenState extends State<ResponsiveTabsScreen> {
  late int _navigationIndex;
  late String _title;
  late List<Widget> _bodies;
  late Widget _body;

  @override
  void initState() {
    _navigationIndex = 0;
    _title = sharedPref.translate('Main screen');
    _bodies = [
      overviewBody(),
      customersBody(),
      remunerationBody(),
    ];
    _body = _bodies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isWidescreen = size.width > size.height;
    return Scaffold(
      appBar: topNavigationBar(isWidescreen) as AppBar,
      drawer: const AppMenu(),
      bottomNavigationBar: bottomNavigationBar(!isWidescreen),
      body: _body,
      // floatingActionButton: const FloatingActionButton(
      //   onPressed: null,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget? bottomNavigationBar(bool show) {
    void onTapBottomNavigationBarItem(int index) {
      if (_navigationIndex != index) {
        setState(() {
          _navigationIndex = index;
          _body = _bodies[_navigationIndex];
        });
      }
    }

    if (!show) {
      return null;
    } else {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            label: sharedPref.translate('Overview'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.people,
            ),
            label: sharedPref.translate('Customers'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.money,
            ),
            label: sharedPref.translate('Remuneration'),
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _navigationIndex,
        onTap: (index) => onTapBottomNavigationBarItem(index),
      );
    }
  }

  Widget topNavigationBar(bool show) {
    return AppBar(
      title: Text(_title),
      flexibleSpace: Row(
        children: !show
            ? [Container()]
            : [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: navigationAppBar(show),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
      ),
    );
  }

  List<Widget> actions() {
    return [
      Container(
        color: Colors.grey,
        child: const Padding(
          padding: EdgeInsets.all(kMinPadding),
          child: TextButton(
            onPressed: null,
            child: Text(
              "Discard",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      Container(
        color: Colors.green,
        child: const Padding(
          padding: EdgeInsets.all(kMinPadding),
          child: TextButton(
            onPressed: null,
            style: ButtonStyle(),
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ];
  }

  Widget navigationAppBar(bool show) {
    if (!show) {
      return Container();
    } else {
      return Container(
        alignment: Alignment.topCenter,
        child: Row(
          children: <Widget>[
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _navigationIndex = 0;
                  _body = _bodies[_navigationIndex];
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home,
                      color: _navigationIndex == 0
                          ? kSecondaryColor
                          : Colors.white),
                  Text(
                    sharedPref.translate('Overview'),
                    style: TextStyle(
                        color: _navigationIndex == 0
                            ? kSecondaryColor
                            : Colors.white),
                  ),
                ],
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _navigationIndex = 1;
                  _body = _bodies[_navigationIndex];
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people,
                      color: _navigationIndex == 1
                          ? kSecondaryColor
                          : Colors.white),
                  Text(
                    sharedPref.translate('Customers'),
                    style: TextStyle(
                        color: _navigationIndex == 1
                            ? kSecondaryColor
                            : Colors.white),
                  ),
                ],
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _navigationIndex = 2;
                  _body = _bodies[_navigationIndex];
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home,
                      color: _navigationIndex == 2
                          ? kSecondaryColor
                          : Colors.white),
                  Text(
                    sharedPref.translate('Remuneration'),
                    style: TextStyle(
                        color: _navigationIndex == 2
                            ? kSecondaryColor
                            : Colors.white),
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    }
  }
}
