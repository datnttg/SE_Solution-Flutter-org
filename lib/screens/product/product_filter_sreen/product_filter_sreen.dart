import 'package:flutter/material.dart';
import 'package:se_solution/screens/product/product_filter_sreen/bloc/product_filter_bloc.dart';

import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import 'components/product_filter_form.dart';
import 'components/product_list.dart';
import 'models/product_filter_item_model.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen>
    with SingleTickerProviderStateMixin {
  final bloc = ProductFilterBloc();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    bloc.loadData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  List<ProductFilterItemModel> all = [];
  List<ProductFilterItemModel> normal = [];
  List<ProductFilterItemModel> locked = [];
  List<ProductFilterItemModel> cancelled = [];

  @override
  Widget build(BuildContext context) {
    /// RETURN WIDGET
    return CScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate('Task management'),
            style: const TextStyle(
                fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Create'),
              onPressed: () async {
                final isReload = await Navigator.pushNamed(
                    context, customRouteMapping.taskAdd);
                if (isReload == true) {
                  bloc.loadData();
                }
              },
            ),
          )
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverToBoxAdapter(
              child: SizedBox(
                height: defaultPadding * 2,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: kBgColor,
                padding: const EdgeInsets.all(defaultPadding),
                child: ProductFilterForm(bloc: bloc),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: defaultPadding * 2,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("Normal")} (${normal.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("Locked")} (${locked.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("Cancelled")} (${cancelled.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("All")} (${all.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: TabBarView(
            controller: _tabController,
            children: [
              ProductList(list: normal),
              ProductList(list: locked),
              ProductList(list: cancelled),
              ProductList(list: all),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
