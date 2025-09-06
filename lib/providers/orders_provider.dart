import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../services/api_manager.dart';
import '../utils/api_endpoint.dart';
import '../utils/app_alerts.dart';
import '../utils/helper_functions.dart';
import '../utils/print_log.dart';

class OrdersProvider extends ChangeNotifier {
  final List<OrderModel> orders = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;

  int _page = 1;
  final int _limit = 20;

  Future<void> fetchOrders(BuildContext context) async {
    _page = 1;
    hasMore = true;
    orders.clear();
    isLoading = true;
    notifyListeners();

    try {
      await _fetch(page: _page, limit: _limit, replace: true);
    } catch (e) {
      PrintLogs.printLog('fetchOrders error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreOrders(BuildContext context) async {
    if (isLoading || isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      _page += 1;
      await _fetch(page: _page, limit: _limit, replace: false);
    } catch (e) {
      PrintLogs.printLog('fetchMoreOrders error: $e');
      // rollback page if request failed
      _page = (_page > 1) ? _page - 1 : 1;
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refreshOrders(BuildContext context) async {
    await fetchOrders(context);
  }

  // --- Internal fetch ---

  Future<void> _fetch({
    required int page,
    required int limit,
    required bool replace,
  }) async {
    // TODO: set your real orders list endpoint here
    // Example assumes: GET /orders?page=..&limit=..
    final uri = Uri.parse(ApiEndpoint.customerOrders).replace(
      queryParameters: {'page': page.toString(), 'limit': limit.toString()},
    );

    PrintLogs.printLog('Orders GET: $uri');

    final res = await ApiManager.get(uri.toString());
    PrintLogs.printLog('Orders response: $res');

    if (res == null) {
      HelperFunctions.handleApiMessages({'message': 'No response from server'});
      hasMore = false;
      return;
    }

    final ok =
        (res['status'] == true) ||
        (res['code']?.toString() == '200') ||
        (res['code']?.toString() == '201');

    if (!ok) {
      HelperFunctions.handleApiMessages(res);
      hasMore = false;
      return;
    }

    // Common shapes:
    // a) { status: true, data: { data: [ ... ] } }
    // b) { status: true, data: [ ... ] }
    dynamic payload = res['data'];
    List<OrderModel> list = [];

    if (payload is Map && payload['data'] is List) {
      var orderListTemp = payload['data'] as List;
      for (var element in orderListTemp) {
        list.add(OrderModel.fromJson(element));
      }
    }

    // Map each item to your model if you have one:
    // final mapped = list.map((e) => OrderModel.fromJson(e)).toList();
    final mapped = list; // keep as dynamic maps for now

    if (replace) {
      orders..clear()..addAll(mapped);
    } else {
      orders.addAll(mapped);
    }

    // If returned items < limit, assume no more pages.
    hasMore = mapped.length >= limit;
  }

  ///booking

  Future<void> bookService(
    BuildContext context,
    String serviceId,
    String date,
    TimeOfDay startTime,
    TimeOfDay endTime,
    String notes,
  ) async {
    // Build start/end DateTimes in LOCAL time from date + TimeOfDay
    final startLocal = _combineLocal(date, startTime);
    final endLocal = _combineLocal(date, endTime);

    // ISO UTC timeslot "startZ/endZ"
    final timeslot = '${_isoUtc(startLocal)}/${_isoUtc(endLocal)}';

    // Human label e.g. "Tuesday, Sep 2 Morning (11:00am - 3:00pm)"
    final timeslotLabel = _buildTimeslotLabel(startLocal, endLocal);

    final body = {
      "serviceId": int.tryParse(serviceId) ?? serviceId, // number if possible
      "timeslot": timeslot,
      "timeslotLabel": timeslotLabel,
      "note": notes,
    };
    try {
      final response = await ApiManager.post(ApiEndpoint.customerOrders, body);
      PrintLogs.printLog("bookService response: $response");
      if (response['status'] == true) {
        AppAlerts.showSnackBar(response['data']['message'] ?? 'Order Created');
        Navigator.pop(context);
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      PrintLogs.printLog('Exception fetchServices : $e');
    } finally {
      // updateServicesLoader(false);
    }
  }

  /// ---------- helpers ----------

  DateTime _combineLocal(String yyyymmdd, TimeOfDay t) {
    // Expects "YYYY-MM-DD"; if it contains time, DateTime.parse still works.
    final d = DateTime.parse(yyyymmdd);
    return DateTime(d.year, d.month, d.day, t.hour, t.minute);
  }

  String _isoUtc(DateTime dt) => dt.toUtc().toIso8601String(); // ends with 'Z'

  String _buildTimeslotLabel(DateTime startLocal, DateTime endLocal) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String h12(TimeOfDay t) {
      final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
      final mm = t.minute.toString().padLeft(2, '0');
      final ampm = t.period == DayPeriod.am ? 'am' : 'pm';
      return '$h:${mm}$ampm';
    }

    String periodLabel(int hour) {
      if (hour >= 5 && hour < 12) return 'Morning';
      if (hour >= 12 && hour < 17) return 'Afternoon';
      if (hour >= 17 && hour < 21) return 'Evening';
      return 'Night';
    }

    final wd = weekdays[startLocal.weekday - 1];
    final mo = months[startLocal.month - 1];
    final day = startLocal.day;

    final startTod = TimeOfDay.fromDateTime(startLocal);
    final endTod = TimeOfDay.fromDateTime(endLocal);

    final period = periodLabel(startTod.hour);
    return '$wd, $mo $day $period (${h12(startTod)} - ${h12(endTod)})';
  }
}
