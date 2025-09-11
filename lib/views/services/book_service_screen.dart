import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/selection_object.dart';
import '../../models/service_detail_model.dart';
import '../../providers/orders_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/helper_functions.dart';
import '../../widgets/custom_bottom_nav_section.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/riyal_price_widget.dart';

class BookServiceScreen extends StatefulWidget {
  final ServiceDetailModel service;

  const BookServiceScreen({super.key, required this.service});

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  String currentSelectedMonth = '';
  List<SelectionObject> dates = [];
  List<SelectionObject> time = [];
  var notesTf = TextEditingController();

  // Month cursors
  late final DateTime _minMonthStart; // first day of *current* month
  late DateTime _cursorMonthStart; // first day of the month being shown
  var days = {
    "monday":"",
    "tuesday":"",
    "wednesday":"",
    "thursday":"",
    "friday":"",
    "saturday":"",
    "sunday":"",
  };

  @override
  void initState() {
    super.initState();
    var openingHours = widget.service.operatingHours;
    days['monday'] = openingHours.monday.open.isEmpty && openingHours.monday.close.isEmpty ? 'closed' : 'open';
    days['tuesday'] = openingHours.tuesday.open.isEmpty && openingHours.tuesday.close.isEmpty ? 'closed' : 'open';
    days['wednesday'] = openingHours.wednesday.open.isEmpty && openingHours.wednesday.close.isEmpty ? 'closed' : 'open';
    days['thursday'] = openingHours.thursday.open.isEmpty && openingHours.thursday.close.isEmpty ? 'closed' : 'open';
    days['friday'] = openingHours.friday.open.isEmpty && openingHours.friday.close.isEmpty ? 'closed' : 'open';
    days['saturday'] = openingHours.saturday.open.isEmpty && openingHours.saturday.close.isEmpty ? 'closed' : 'open';
    days['sunday'] = openingHours.sunday.open.isEmpty && openingHours.sunday.close.isEmpty ? 'closed' : 'open';

    final now = DateTime.now();
    _minMonthStart = DateTime(now.year, now.month, 1);
    _cursorMonthStart = _minMonthStart;
    _populateMonth(_cursorMonthStart);
    loadHardcodedTimeSlots();
  }

  // ----------------- PUBLIC API -----------------

  void loadHardcodedTimeSlots() {
    const raw = [
      [10, 12],
      [12, 14],
      [14, 16],
      [16, 18],
      [18, 20],
      [20, 22],
    ];

    time = raw.map((pair) {
      final start = TimeOfDay(hour: pair[0], minute: 0);
      final end = TimeOfDay(hour: pair[1], minute: 0);
      final label = '${_fmt(start)} - ${_fmt(end)}';
      final idVal = '${_two(pair[0])}-${_two(pair[1])}';

      return SelectionObject(
        id: idVal,
        title: label,
        // e.g. "10:00 - 12:00"
        value: idVal,
        // e.g. "10-12"
        isActive: true,
        data: {
          'start': start,
          'end': end,
        }, // keep the TimeOfDay range for API/use
      );
    }).toList();
    time[0].isSelected = true;
    setState(() {});
  }

  // --- tiny helpers ---
  String _fmt(TimeOfDay t) => '${_two(t.hour)}:${_two(t.minute)}';

  String _two(int n) => n.toString().padLeft(2, '0');

  /// Go to next month and rebuild dates (1 -> end of month)
  void goToNextMonth() {
    _cursorMonthStart = DateTime(
      _cursorMonthStart.year,
      _cursorMonthStart.month + 1,
      1,
    );
    _populateMonth(_cursorMonthStart);
  }

  /// Go to previous month (clamped so it never goes before *current* month)
  void goToPrevMonth() {
    final prev = DateTime(
      _cursorMonthStart.year,
      _cursorMonthStart.month - 1,
      1,
    );
    if (_isBeforeMonth(prev, _minMonthStart)) return; // already at min
    _cursorMonthStart = prev;
    _populateMonth(_cursorMonthStart);
  }

  /// Jump to any future month (clamped to >= current month)
  void goToMonth(DateTime anyDayInTargetMonth) {
    final target = DateTime(
      anyDayInTargetMonth.year,
      anyDayInTargetMonth.month,
      1,
    );
    _cursorMonthStart = _isBeforeMonth(target, _minMonthStart)
        ? _minMonthStart
        : target;
    _populateMonth(_cursorMonthStart);
  }

  /// Optional: load N future days starting *today* (continuous range)
  void loadFutureDays(int days) {
    final today = _todayMidnight();
    dates
      ..clear()
      ..addAll(
        List.generate(days, (i) {
          final dt = today.add(Duration(days: i));
          return _toSelection(dt);
        }),
      );
    currentSelectedMonth = _formatMonthYear(
      DateTime(today.year, today.month, 1),
    );
    setState(() {});
  }

  // ----------------- INTERNAL -----------------

  /// Build `dates` for the month at [monthStart].
  /// If it's the **current month**, start from **today**; otherwise from the 1st.
  void _populateMonth(DateTime monthStart) {
    final now = _todayMidnight();
    final isCurrentMonth =
        (monthStart.year == now.year && monthStart.month == now.month);

    final startDay = isCurrentMonth ? now.day : 1;
    final lastDay = _daysInMonth(monthStart.year, monthStart.month);

    dates.clear();
    for (int d = startDay; d <= lastDay; d++) {
      final dt = DateTime(monthStart.year, monthStart.month, d);
      if (days[HelperFunctions.getDateTimeString(dt.toString(), format: 'EEEE').toLowerCase()] == 'closed'){
        continue;
      }
      dates.add(_toSelection(dt));
    }

    currentSelectedMonth = _formatMonthYear(monthStart);
    dates[0].isSelected = true;
    setState(() {});
  }

  SelectionObject _toSelection(DateTime dt) {
    final iso = _isoDate(dt);
    return SelectionObject(
      id: iso,
      title: dt.day.toString().padLeft(2, '0'),
      titleAr: _weekdayShortAr(dt),
      // optional: Arabic short day
      value: iso,
      // e.g., "2025-09-06"
      isActive: true,
      // mark available
      data: dt, // keep the DateTime
    );
  }

  // ----------------- DATE UTILS -----------------

  bool _isBeforeMonth(DateTime a, DateTime b) {
    // Compare by year+month only
    if (a.year < b.year) return true;
    if (a.year > b.year) return false;
    return a.month < b.month;
  }

  DateTime _todayMidnight() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  int _daysInMonth(int year, int month) {
    final firstNext = (month == 12)
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    return firstNext.subtract(const Duration(days: 1)).day;
  }

  String _isoDate(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

  String _formatMonthYear(DateTime d) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }

  // String _weekdayShort(DateTime d) {
  //   const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  //   return names[d.weekday - 1];
  // }

  String _weekdayShortAr(DateTime d) {
    // Optional Arabic short names
    const names = [
      'الاث',
      'الثلاث',
      'الأربع',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return names[d.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Book Service'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: widget.service.name,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                RiyalPriceWidget(
                  child: CustomText(
                    text: widget.service.price,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: 'Select Date',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    goToPrevMonth();
                  },
                  child: Icon(Icons.keyboard_arrow_left, size: 24),
                ),
                SizedBox(width: 10),
                CustomText(text: currentSelectedMonth, fontSize: 15),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    goToNextMonth();
                  },
                  child: Icon(Icons.keyboard_arrow_right, size: 24),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  return Material(
                    color: dates[index].isSelected
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        selectDate(index);
                      },
                      child: Container(
                        constraints: BoxConstraints(minWidth: 100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 0.5,
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: dates[index].title,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: dates[index].isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                            ),
                            SizedBox(height: 5),
                            CustomText(
                              text: HelperFunctions.getDateTimeString(
                                dates[index].data.toString(),
                                format: 'EEEE',
                              ),
                              color: dates[index].isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: dates.length,
              ),
            ),
            SizedBox(height: 16),
            CustomText(
              text: 'Select Time',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: time
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        var index = time.indexOf(e);
                        onTimeSelection(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: e.isSelected
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withAlpha(50),
                        ),
                        child: CustomText(
                          text: e.title,
                          color: e.isSelected
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            SizedBox(height: 16),
            CustomText(
              text: 'Note (Optional)',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16),
            RoundedTextField(
              hintText: 'Any special instruction or requirements...',
              maxLines: 10,
              controller: notesTf,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavSection(text: 'Submit', onTap: (){
        var selectedDate = dates.where((element) => element.isSelected).toList();
        var selectedTime = time.where((element) => element.isSelected).toList();
        Provider.of<OrdersProvider>(context, listen: false).bookService(
          context, widget.service.id,
          selectedDate[0].id, selectedTime[0].data['start'], selectedTime[0].data['end'],
          notesTf.text.trim());
      }),
    );
  }

  void selectDate(int index) {
    if (dates[index].isSelected) return;
    for (var e in dates) {
      e.isSelected = false;
    }
    dates[index].isSelected = true;
    setState(() {});
  }

  void onTimeSelection(int index) {
    if (time[index].isSelected) return;
    for (var e in time) {
      e.isSelected = false;
    }
    time[index].isSelected = true;
    setState(() {});
  }
}
