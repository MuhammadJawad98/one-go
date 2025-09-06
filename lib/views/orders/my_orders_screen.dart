import 'package:car_wash_app/views/orders/widgets/order_card_skeleton_widget.dart';
import 'package:car_wash_app/views/orders/widgets/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order_model.dart';
import '../../providers/orders_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_text.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  String _filter = 'All'; // All | Upcoming | Completed | Cancelled
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersProvider>().fetchOrders(context);
    });

    // optional: infinite scroll (if your provider supports pagination)
    _scrollCtrl.addListener(() {
      final p = context.read<OrdersProvider>();
      if (_scrollCtrl.position.pixels >=
              _scrollCtrl.position.maxScrollExtent - 200 &&
          !p.isLoading &&
          p.hasMore) {
        p.fetchMoreOrders(context);
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (context, p, _) {
        final all = p.orders; // <-- make sure your provider exposes this
        final items = _applyFilter(all, _filter);

        return Scaffold(
          appBar: AppBar(
            title: const CustomText(text: 'My Orders'),
            elevation: 0,
          ),
          body: Column(
                  children: [
                    _FiltersBar(
                      filter: _filter,
                      onChanged: (val) => setState(() => _filter = val),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () => p.refreshOrders(context),
                        child: _buildBody(p, items),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildBody(OrdersProvider p, List<OrderModel> items) {
    if (p.isLoading && items.isEmpty) {
      return const _LoadingList();
    }

    if (items.isEmpty) {
      return const _EmptyState();
    }

    return ListView.separated(
      controller: _scrollCtrl,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemBuilder: (_, i) {
        final vm = items[i];
        return OrderCardWidget(vm: vm, onView: () {}, onCancel: null);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: items.length + (p.isLoadingMore ? 1 : 0),
    );
  }

  List<OrderModel> _applyFilter(List<OrderModel> src, String filter) {
    if (filter == 'All') return src;
    return src.where((obj) {
      return obj.status.toLowerCase() == filter.toLowerCase();
    }).toList();
  }
}

class _FiltersBar extends StatelessWidget {
  final String filter;
  final ValueChanged<String> onChanged;

  const _FiltersBar({required this.filter, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = const ['All', 'Pending', 'Confirmed'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Row(
        children: [
          for (final f in items) ...[
            ChoiceChip(
              label: Text(f),
              selected: f == filter,
              onSelected: (_) => onChanged(f),
              selectedColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: f == filter ? Colors.white : AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              shape: StadiumBorder(
                side: BorderSide(
                  color: f == filter
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withAlpha(40),
                ),
              ),
              backgroundColor: AppColors.primaryColor.withAlpha(8),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemBuilder: (_, __) => OrderCardSkeleton(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: 6,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.black26),
            SizedBox(height: 16),
            CustomText(
              text: 'No orders yet',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8),
            CustomText(
              text: 'Your booked services will appear here.',
              color: Colors.black54,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}


