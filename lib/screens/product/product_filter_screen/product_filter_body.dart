import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/enums/ui_enums.dart';
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
    return BlocBuilder<ProductFilterBloc, ProductFilterState>(
      builder: (context, state) {
        var all = state.products ?? [];
        if (all.isNotEmpty) {
          all.sort((a, b) => b.name == null
              ? -1
              : a.name == null
                  ? 1
                  : b.name!.compareTo(a.name!));
        }
        var normal =
            all.where((e) => ['Normal'].any((u) => u == e.statusCode)).toList();
        var locked =
            all.where((e) => ['Locked'].any((u) => u == e.statusCode)).toList();
        var cancelled = all
            .where((e) => ['Cancelled'].any((u) => u == e.statusCode))
            .toList();
        return RefreshIndicator(
          onRefresh: () async {
            return context
                .read<ProductFilterBloc>()
                .add(ProductFilterSubmitted());
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverToBoxAdapter(
                  /// FILTER FORM
                  child: ProductFilterForm(),
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
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? ProductList(list: normal)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? ProductList(list: locked)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? ProductList(list: cancelled)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? ProductList(list: all)
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        );
      },
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
