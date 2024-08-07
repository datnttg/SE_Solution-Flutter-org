import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import 'bloc/product_filter_bloc.dart';
import 'bloc/product_filter_events.dart';
import 'bloc/product_filter_states.dart';
import 'components/product_filter_form.dart';
import 'components/product_list.dart';

class ProductFilterBody extends StatefulWidget {
  const ProductFilterBody({super.key});

  @override
  State<ProductFilterBody> createState() => _ProductFilterBodyState();
}

class _ProductFilterBodyState extends State<ProductFilterBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    context.read<ProductFilterBloc>().add(InitProductFilterData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            height: constrains.maxHeight,
            width: constrains.maxWidth,
            child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
              builder: (context, state) {
                var all = state.products ?? [];
                if (all.isNotEmpty) {
                  all.sort((a, b) => b.name == null
                      ? -1
                      : a.name == null
                          ? 1
                          : b.name!.compareTo(a.name!));
                }
                var normal = all
                    .where((e) => ['Normal'].any((u) => u == e.statusCode))
                    .toList();
                var locked = all
                    .where((e) => ['Locked'].any((u) => u == e.statusCode))
                    .toList();
                var cancelled = all
                    .where((e) => ['Cancelled'].any((u) => u == e.statusCode))
                    .toList();
                return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          color: kBgColor,
                          padding: const EdgeInsets.only(
                              left: defaultPadding * 2,
                              right: defaultPadding * 2),

                          /// FILTER FORM
                          child: const ProductFilterForm(),
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
                                      '${sharedPref.translate("Normal")} (${normal.length})',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Tab(
                                  child: Text(
                                      '${sharedPref.translate("Locked")} (${locked.length})',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Tab(
                                  child: Text(
                                      '${sharedPref.translate("Cancelled")} (${cancelled.length})',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Tab(
                                  child: Text(
                                      '${sharedPref.translate("All")} (${all.length})',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
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
                        /// PRODUCT LIST
                        ProductList(list: normal),
                        ProductList(list: locked),
                        ProductList(list: cancelled),
                        ProductList(list: all),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// ADD PRODUCT BUTTON
          // Positioned(
          //   bottom: 50,
          //   right: 50,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: kBgColorRow1,
          //       border: Border.all(width: 1, color: kBgColorHeader),
          //       borderRadius: BorderRadius.circular(800),
          //     ),
          //     child: IconButton(
          //       icon: const Icon(Icons.add),
          //       padding: const EdgeInsets.all(15),
          //       onPressed: () async {
          //         if (Responsive.isSmallWidth(context)) {
          //           final isReload = await Navigator.pushNamed(
          //               context, customRouteMapping.productAdd);
          //           if (isReload == true) {
          //             widget.bloc.loadData();
          //           }
          //         } else {
          //           widget.bloc.eventController
          //               .add(ChangeSelectedProduct(productId: ''));
          //         }
          //       },
          //     ),
          //   ),
          // ),
        ],
      );
    });
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
