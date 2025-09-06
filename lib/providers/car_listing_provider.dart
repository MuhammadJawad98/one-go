import 'package:flutter/material.dart';
import 'package:car_wash_app/models/car_listing_model.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:car_wash_app/utils/print_log.dart';

import '../services/api_manager.dart';
import '../utils/api_endpoint.dart';

class CarListingProvider extends ChangeNotifier {
  // public (read-only)
  List<CarListingModel> get cars => List.unmodifiable(_cars);
  bool get isInitialLoading => _isInitialLoading;
  bool get isPageLoading => _isPageLoading;
  bool get isLoadingMore => _isPageLoading; // compat alias
  bool get hasMore => _hasMore;

  String get statusFilter => _statusFilter; // all | draft | published | underReview
  String get query => _query;

  // private
  final List<CarListingModel> _cars = [];
  bool _isInitialLoading = false;
  bool _isPageLoading = false;
  bool _hasMore = true;

  int _page = 1;
  final int _limit = 20;

  String _statusFilter = 'all';
  String _query = '';

  // fetch first page
  Future<void> fetchMyCars([BuildContext? context]) async {
    if (_isInitialLoading) return;
    _isInitialLoading = true;
    _resetPaging();
    notifyListeners();

    try {
      await _fetch(page: _page, replace: true);
    } catch (e, st) {
      PrintLogs.printLog('MyCarsProvider.fetchMyCars error: $e\n$st');
    } finally {
      _isInitialLoading = false;
      notifyListeners();
    }
  }

  // fetch next page
  Future<void> fetchMoreMyCars([BuildContext? context]) async {
    if (_isInitialLoading || _isPageLoading || !_hasMore) return;
    _isPageLoading = true;
    notifyListeners();
    try {
      _page += 1;
      await _fetch(page: _page, replace: false);
    } catch (e, st) {
      PrintLogs.printLog('MyCarsProvider.fetchMore error: $e\n$st');
      _page = (_page > 1) ? _page - 1 : 1;
    } finally {
      _isPageLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMyCars([BuildContext? context]) async {
    await fetchMyCars(context);
  }

  // filters
  void setStatusFilter(String status) { // all | draft | published | underReview
    if (_statusFilter == status) return;
    _statusFilter = status;
    fetchMyCars();
  }

  void setQuery(String q) {
    _query = q.trim();
    fetchMyCars();
  }

  // actions (hook to your flows)
  void onViewCar(BuildContext context, String id) {
    // TODO: navigate to details
    PrintLogs.printLog('View car $id');
  }

  Future<void> deleteCar(BuildContext context, String id) async {
    // TODO: call delete endpoint if available
    PrintLogs.printLog('Delete car $id');
  }

  // internals
  void _resetPaging() {
    _cars.clear();
    _page = 1;
    _hasMore = true;
  }

  Future<void> _fetch({required int page, required bool replace}) async {
    final params = <String, String>{
      'page': page.toString(),
      'limit': _limit.toString(),
      if (_query.isNotEmpty) 'keywords': _query,
      if (_statusFilter != 'all') 'status': _statusFilter, // backend must support
    };

    // Adjust endpoint if needed
    final uri = Uri.parse(ApiEndpoint.customerCars).replace(queryParameters: params);

    PrintLogs.printLog('MyCars GET: $uri');
    final res = await ApiManager.get(uri.toString());
    PrintLogs.printLog('MyCars response: $res');

    if (res == null) {
      HelperFunctions.handleApiMessages({'message': 'No response from server'});
      _hasMore = false;
      return;
    }
    final ok = (res['status'] == true) ||
        (res['code']?.toString() == '200') ||
        (res['code']?.toString() == '201');
    if (!ok) {
      HelperFunctions.handleApiMessages(res);
      _hasMore = false;
      return;
    }

    dynamic payload = res['data'];
    List list;
    if (payload is Map && payload['data'] is List) {
      list = payload['data'] as List;
    } else if (payload is List) {
      list = payload;
    } else {
      list = const [];
    }

    final items = list
        .map((e) => CarListingModel.fromJson(e as Map<String, dynamic>))
        .toList();

    if (replace) {
      _cars
        ..clear()
        ..addAll(items);
    } else {
      _cars.addAll(items);
    }

    _hasMore = items.length >= _limit;
  }
}
