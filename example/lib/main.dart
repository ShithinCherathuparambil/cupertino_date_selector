import 'package:cupertino_date_selector/cupertino_date_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recipes_screen.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cupertino_date_selector example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  String _lastResult = 'Tap a button to open a selector.';

  void _setResult(String text) {
    setState(() => _lastResult = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('cupertino_date_selector')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_lastResult),
            ),
          ),
          const SizedBox(height: 8),
          _demoButton('Recipes (advanced patterns)', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const RecipesScreen()),
            );
          }),
          _demoButton('Items', () async {
            await CupertinoDateSelector.items(
              items: const [Text('One'), Text('Two'), Text('Three')],
              selectedItemIndex: 0,
              theme: const CupertinoDateSelectorThemeData(
                defaultButtonText: 'Done',
              ),
              onSubmit: (index) => _setResult('Items → index: $index'),
            ).show(context);
          }),
          _demoButton('Date', () async {
            final now = DateTime.now();
            await CupertinoDateSelector.date(
              initialDateTime: now,
              minDateTime: now.subtract(const Duration(days: 365)),
              maxDateTime: now.add(const Duration(days: 365)),
              onSubmit: (d) => _setResult('Date → $d'),
            ).show(context);
          }),
          _demoButton('Time', () async {
            await CupertinoDateSelector.time(
              initialDateTime: DateTime.now(),
              minuteInterval: 5,
              use24hFormat: true,
              onSubmit: (d) => _setResult('Time → $d'),
            ).show(context);
          }),
          _demoButton('Date and Time', () async {
            final now = DateTime.now();
            await CupertinoDateSelector.dateTime(
              initialDateTime: now,
              minDateTime: now.subtract(const Duration(days: 7)),
              maxDateTime: now.add(const Duration(days: 30)),
              minuteInterval: 15,
              use24hFormat: false,
              onSubmit: (d) => _setResult('DateTime → $d'),
            ).show(context);
          }),
          _demoButton('Year', () async {
            final now = DateTime.now();
            await CupertinoDateSelector.year(
              initialDateTime: now,
              minDateTime: DateTime(now.year - 10),
              maxDateTime: DateTime(now.year + 10),
              onSubmit: (d) => _setResult('Year → $d'),
            ).show(context);
          }),
          _demoButton('Month & year', () async {
            final now = DateTime.now();
            await CupertinoDateSelector.monthYear(
              initialDateTime: now,
              minDateTime: DateTime(now.year - 2),
              maxDateTime: DateTime(now.year + 2, 12),
              onSubmit: (d) => _setResult('MonthYear → $d'),
            ).show(context);
          }),
          _demoButton(
            'Month & year (design example)',
            () => _showDesignMonthYearSelector(context),
          ),
          _demoButton('Month & year widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const MonthYearWidgetScreen(),
              ),
            );
          }),
          _demoButton('Items widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ItemsWidgetScreen(),
              ),
            );
          }),
          _demoButton('Date widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const DateWidgetScreen()),
            );
          }),
          _demoButton('Time widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const TimeWidgetScreen()),
            );
          }),
          _demoButton('DateTime widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const DateTimeWidgetScreen(),
              ),
            );
          }),
          _demoButton('Year widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const YearWidgetScreen()),
            );
          }),
          _demoButton('Month widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const MonthWidgetScreen(),
              ),
            );
          }),
          _demoButton('Duration widget screen', () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const DurationWidgetScreen(),
              ),
            );
          }),
          _demoButton('Month', () async {
            await CupertinoDateSelector.month(
              initialDateTime: DateTime.now(),
              onSubmit: (d) => _setResult('Month → ${d.month}'),
            ).show(context);
          }),
          _demoButton('Duration', () async {
            await CupertinoDateSelector.duration(
              initialDuration: const Duration(hours: 1, minutes: 30),
              onSubmit: (d) => _setResult('Duration → $d'),
            ).show(context);
          }),
        ],
      ),
    );
  }

  Widget _demoButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(onPressed: onPressed, child: Text(label)),
      ),
    );
  }

  Future<void> _showDesignMonthYearSelector(BuildContext context) async {
    final List<String> months = <String>[
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

    const int minYear = 2024;
    const int maxYear = 2028;
    final List<int> years = List<int>.generate(
      maxYear - minYear + 1,
      (index) => minYear + index,
    );

    int selectedMonth = 3;
    int selectedYear = 2026;
    final monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
    final yearController = FixedExtentScrollController(
      initialItem: selectedYear - minYear,
    );

    final selected = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            Future<void> moveBy(int delta) async {
              final int currentMonthIndex = selectedMonth - 1;
              final int currentYearIndex = selectedYear - minYear;
              final int totalIndex =
                  (currentYearIndex * 12) + currentMonthIndex + delta;
              final int clamped = totalIndex.clamp(0, (years.length * 12) - 1);
              final int nextYearIndex = clamped ~/ 12;
              final int nextMonthIndex = clamped % 12;

              setSheetState(() {
                selectedMonth = nextMonthIndex + 1;
                selectedYear = years[nextYearIndex];
              });

              await monthController.animateToItem(
                nextMonthIndex,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
              );
              await yearController.animateToItem(
                nextYearIndex,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
              );
            }

            return Container(
              height: 390,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 139,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAEBED),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const Text(
                      'Choose Month & Year',
                      style: TextStyle(
                        fontSize: 16,
                        height: 19 / 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF181818),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      height: 37,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => moveBy(-1),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(
                              width: 24,
                              height: 24,
                            ),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF292D32),
                              size: 24,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${months[selectedMonth - 1]} $selectedYear',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 19 / 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF181818),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => moveBy(1),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(
                              width: 24,
                              height: 24,
                            ),
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF292D32),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IgnorePointer(
                            child: Container(
                              height: 37,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFDFDF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CupertinoPicker(
                                  itemExtent: 32,
                                  scrollController: monthController,
                                  onSelectedItemChanged: (index) {
                                    setSheetState(() {
                                      selectedMonth = index + 1;
                                    });
                                  },
                                  children: months
                                      .map(
                                        (month) => Center(
                                          child: Text(
                                            month,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  itemExtent: 32,
                                  scrollController: yearController,
                                  onSelectedItemChanged: (index) {
                                    setSheetState(() {
                                      selectedYear = years[index];
                                    });
                                  },
                                  children: years
                                      .map(
                                        (year) => Center(
                                          child: Text(
                                            year.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF181818),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          Navigator.of(
                            ctx,
                          ).pop(DateTime(selectedYear, selectedMonth));
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16,
                            height: 22 / 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (selected != null) {
      _setResult('Design MonthYear → $selected');
    }
  }
}

class MonthYearWidgetScreen extends StatefulWidget {
  const MonthYearWidgetScreen({super.key});

  @override
  State<MonthYearWidgetScreen> createState() => _MonthYearWidgetScreenState();
}

class _MonthYearWidgetScreenState extends State<MonthYearWidgetScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Month & year widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected: ${selectedDate.month}/${selectedDate.year}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.monthYear(
            initialDateTime: selectedDate,
            minDateTime: DateTime(DateTime.now().year - 2, 1),
            maxDateTime: DateTime(DateTime.now().year + 100, 12),
            onChanged: (DateTime d) {
              setState(() => selectedDate = d);
            },
          ),
        ],
      ),
    );
  }
}

class ItemsWidgetScreen extends StatefulWidget {
  const ItemsWidgetScreen({super.key});

  @override
  State<ItemsWidgetScreen> createState() => _ItemsWidgetScreenState();
}

class _ItemsWidgetScreenState extends State<ItemsWidgetScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Items widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected index: $selectedIndex',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.items(
            items: const [Text('One'), Text('Two'), Text('Three')],
            selectedItemIndex: selectedIndex,
            onChanged: (int index) {
              setState(() => selectedIndex = index);
            },
          ),
        ],
      ),
    );
  }
}

class DateWidgetScreen extends StatefulWidget {
  const DateWidgetScreen({super.key});

  @override
  State<DateWidgetScreen> createState() => _DateWidgetScreenState();
}

class _DateWidgetScreenState extends State<DateWidgetScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Date widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected: ${selectedDate.toLocal()}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.date(
            initialDateTime: selectedDate,
            minDateTime: now.subtract(const Duration(days: 365)),
            maxDateTime: now.add(const Duration(days: 365)),
            onChanged: (DateTime d) {
              setState(() => selectedDate = d);
            },
          ),
        ],
      ),
    );
  }
}

class TimeWidgetScreen extends StatefulWidget {
  const TimeWidgetScreen({super.key});

  @override
  State<TimeWidgetScreen> createState() => _TimeWidgetScreenState();
}

class _TimeWidgetScreenState extends State<TimeWidgetScreen> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.time(
            initialDateTime: selectedTime,
            minuteInterval: 5,
            use24hFormat: true,
            onChanged: (DateTime d) {
              setState(() => selectedTime = d);
            },
            onSubmit: (DateTime d) {
              setState(() => selectedTime = d);
            },
            headerBuilder: (context, close) => Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.red),
              child: Text('Header'),
            ),
          ),
        ],
      ),
    );
  }
}

class DateTimeWidgetScreen extends StatefulWidget {
  const DateTimeWidgetScreen({super.key});

  @override
  State<DateTimeWidgetScreen> createState() => _DateTimeWidgetScreenState();
}

class _DateTimeWidgetScreenState extends State<DateTimeWidgetScreen> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('DateTime widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected: $selectedDateTime',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.dateTime(
            initialDateTime: selectedDateTime,
            minDateTime: now.subtract(const Duration(days: 7)),
            maxDateTime: now.add(const Duration(days: 30)),
            minuteInterval: 15,
            onChanged: (DateTime d) {
              setState(() => selectedDateTime = d);
            },
          ),
        ],
      ),
    );
  }
}

class YearWidgetScreen extends StatefulWidget {
  const YearWidgetScreen({super.key});

  @override
  State<YearWidgetScreen> createState() => _YearWidgetScreenState();
}

class _YearWidgetScreenState extends State<YearWidgetScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Year widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected year: ${selectedDate.year}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.year(
            initialDateTime: selectedDate,
            minDateTime: DateTime(now.year - 10),
            maxDateTime: DateTime(now.year + 10),
            onChanged: (DateTime d) {
              setState(() => selectedDate = d);
            },
          ),
        ],
      ),
    );
  }
}

class MonthWidgetScreen extends StatefulWidget {
  const MonthWidgetScreen({super.key});

  @override
  State<MonthWidgetScreen> createState() => _MonthWidgetScreenState();
}

class _MonthWidgetScreenState extends State<MonthWidgetScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Month widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected month: ${selectedDate.month}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.month(
            initialDateTime: selectedDate,
            onChanged: (DateTime d) {
              setState(() => selectedDate = d);
            },
          ),
        ],
      ),
    );
  }
}

class DurationWidgetScreen extends StatefulWidget {
  const DurationWidgetScreen({super.key});

  @override
  State<DurationWidgetScreen> createState() => _DurationWidgetScreenState();
}

class _DurationWidgetScreenState extends State<DurationWidgetScreen> {
  Duration selectedDuration = const Duration(hours: 1, minutes: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Duration widget')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected duration: $selectedDuration',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CupertinoDateSelectorWidget.duration(
            initialDuration: selectedDuration,
            onChanged: (Duration d) {
              setState(() => selectedDuration = d);
            },
          ),
        ],
      ),
    );
  }
}
