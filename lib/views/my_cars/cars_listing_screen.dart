import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../views/my_cars/widget/car_card_skeleton.dart';
import '../../views/my_cars/widget/car_card_widget.dart';
import '../../providers/car_listing_provider.dart';
import '../../widgets/custom_empty_view.dart';
import '../../widgets/custom_text.dart';
import 'widget/tab_chip_widget.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CarListingProvider>().fetchMyCars(context);
    });

    _scrollCtrl.addListener(() {
      final p = context.read<CarListingProvider>();
      if (_scrollCtrl.position.pixels >=
              _scrollCtrl.position.maxScrollExtent - 200 &&
          !p.isLoadingMore &&
          p.hasMore) {
        p.fetchMoreMyCars(context);
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarListingProvider>(
      builder: (context, p, _) {
        final cars = p.cars;

        return Scaffold(
          appBar: AppBar(
            title: const CustomText(text: 'My Cars'),
            elevation: 0,
          ),
          body: Column(
            children: [
              _SearchAndTabs(
                controller: _searchCtrl,
                selected: p.statusFilter,
                onSearchChanged: (v) => p.setQuery(v),
                onTabChanged: (v) => p.setStatusFilter(v),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => p.refreshMyCars(context),
                  child: p.isInitialLoading && cars.isEmpty
                      ? const CarCardSkeleton()
                      : cars.isEmpty
                      ? const CustomEmptyView()
                      : ListView.separated(
                          controller: _scrollCtrl,
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                          itemBuilder: (_, i) {
                            if (i >= cars.length) {
                              return const CarCardSkeleton();
                            }
                            final c = cars[i];
                            return CarCardWidget(model: c);
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemCount: cars.length + (p.isLoadingMore ? 1 : 0),
                        ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

/// Top search bar + status tabs (All / Draft / Published / Under Review)
class _SearchAndTabs extends StatelessWidget {
  final TextEditingController controller;
  final String selected;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onTabChanged;

  const _SearchAndTabs({
    required this.controller,
    required this.selected,
    required this.onSearchChanged,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = const [
      ['all', 'All Cars'],
      ['draft', 'Draft'],
      ['published', 'Published'],
      ['underReview', 'Under Review'],
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        children: [
          // Search
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search by make, model, or year…',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Tabs
          SizedBox(
            height: 40, // adjust to your TabChip height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final t = tabs[index];
                return TabChip(
                  label: t[1],
                  selected: selected == t[0],
                  onTap: () => onTabChanged(t[0]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
