import 'package:cupertino_date_selector/cupertino_date_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recipes_screen.dart';

/// Shared demo theme: custom sheet + wheel [CupertinoDateSelectorThemeData.backgroundColor].
const CupertinoDateSelectorThemeData kExampleCupertinoPickerTheme =
    CupertinoDateSelectorThemeData(
      backgroundColor: Color(0xFFE8EEF5),
      itemTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Color(0xFF181818),
      ),
    );

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  static const Color _seed = Color(0xFF4F46E5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cupertino_date_selector example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
        ),
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
  String _lastResult = 'Tap an item below to run a demo.';

  void _setResult(String text) {
    setState(() => _lastResult = text);
  }

  static const EdgeInsets _pagePadding = EdgeInsets.fromLTRB(20, 0, 20, 32);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar.large(
            pinned: true,
            backgroundColor: cs.surface,
            surfaceTintColor: cs.surfaceTint,
            title: const Text('Date selector'),
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primaryContainer.withValues(alpha: 0.35),
                      cs.surface,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: _pagePadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Cupertino-style wheels for Flutter — modals, inline pages, and custom chrome.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),
                _ResultPanel(result: _lastResult, colorScheme: cs),
                const SizedBox(height: 28),
                _FeaturedRecipesCard(
                  onOpen: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const RecipesScreen(),
                      ),
                    );
                  },
                  colorScheme: cs,
                ),
                const SizedBox(height: 12),
                _SectionTitle(
                  icon: Icons.layers_outlined,
                  label: 'Modal bottom sheets',
                  colorScheme: cs,
                ),
                _DemoTile(
                  icon: Icons.list_alt_rounded,
                  title: 'Custom items',
                  subtitle: 'Indexed list of widgets',
                  colorScheme: cs,
                  onTap: () async {
                    await CupertinoDateSelector.items(
                      items: const [Text('One'), Text('Two'), Text('Three')],
                      selectedItemIndex: 0,
                      theme: kExampleCupertinoPickerTheme.copyWith(
                        defaultButtonText: 'Done',
                      ),
                      onSubmit: (index) => _setResult('Items → index: $index'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.calendar_today_rounded,
                  title: 'Date',
                  subtitle: 'Day / month / year',
                  colorScheme: cs,
                  onTap: () async {
                    final now = DateTime.now();
                    await CupertinoDateSelector.date(
                      initialDateTime: now,
                      minDateTime: now.subtract(const Duration(days: 365)),
                      maxDateTime: now.add(const Duration(days: 365)),
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('Date → $d'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.schedule_rounded,
                  title: 'Time',
                  subtitle: '5-minute steps, 24h',
                  colorScheme: cs,
                  onTap: () async {
                    await CupertinoDateSelector.time(
                      initialDateTime: DateTime.now(),
                      minuteInterval: 5,
                      use24hFormat: true,
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('Time → $d'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.event_rounded,
                  title: 'Date and time',
                  subtitle: 'Combined picker',
                  colorScheme: cs,
                  onTap: () async {
                    final now = DateTime.now();
                    await CupertinoDateSelector.dateTime(
                      initialDateTime: now,
                      minDateTime: now.subtract(const Duration(days: 7)),
                      maxDateTime: now.add(const Duration(days: 30)),
                      minuteInterval: 15,
                      use24hFormat: false,
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('DateTime → $d'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.date_range_rounded,
                  title: 'Year',
                  colorScheme: cs,
                  onTap: () async {
                    final now = DateTime.now();
                    await CupertinoDateSelector.year(
                      initialDateTime: now,
                      minDateTime: DateTime(now.year - 10),
                      maxDateTime: DateTime(now.year + 10),
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('Year → $d'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.calendar_month_rounded,
                  title: 'Month & year',
                  colorScheme: cs,
                  onTap: () async {
                    final now = DateTime.now();
                    await CupertinoDateSelector.monthYear(
                      initialDateTime: now,
                      minDateTime: DateTime(now.year - 2),
                      maxDateTime: DateTime(now.year + 2, 12),
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('MonthYear → $d'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.view_week_rounded,
                  title: 'Month only',
                  colorScheme: cs,
                  onTap: () async {
                    await CupertinoDateSelector.month(
                      initialDateTime: DateTime.now(),
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('Month → ${d.month}'),
                    ).show(context);
                  },
                ),
                _DemoTile(
                  icon: Icons.timer_outlined,
                  title: 'Duration',
                  subtitle: 'Timer picker',
                  colorScheme: cs,
                  onTap: () async {
                    await CupertinoDateSelector.duration(
                      initialDuration: const Duration(hours: 1, minutes: 30),
                      theme: kExampleCupertinoPickerTheme,
                      onSubmit: (d) => _setResult('Duration → $d'),
                    ).show(context);
                  },
                ),
                _SectionTitle(
                  icon: Icons.palette_outlined,
                  label: 'Design & layout',
                  colorScheme: cs,
                ),
                _DemoTile(
                  icon: Icons.brush_rounded,
                  title: 'Month & year (custom sheet)',
                  subtitle: 'Hand-built bottom sheet UI',
                  colorScheme: cs,
                  onTap: () => _showDesignMonthYearSelector(context),
                ),
                _SectionTitle(
                  icon: Icons.phone_android_rounded,
                  label: 'Full-screen inline demos',
                  colorScheme: cs,
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Month & year widget',
                  subtitle: 'Navigate',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MonthYearWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Items widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ItemsWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Date widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const DateWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Time widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const TimeWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'DateTime widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const DateTimeWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Year widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const YearWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Month widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MonthWidgetScreen(),
                      ),
                    );
                  },
                ),
                _DemoTile(
                  icon: Icons.open_in_full_rounded,
                  title: 'Duration widget',
                  colorScheme: cs,
                  trailing: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const DurationWidgetScreen(),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
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

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({required this.result, required this.colorScheme});

  final String result;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 22,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Last result',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              result,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.45,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedRecipesCard extends StatelessWidget {
  const _FeaturedRecipesCard({
    required this.onOpen,
    required this.colorScheme,
  });

  final VoidCallback onOpen;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: colorScheme.primary,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: colorScheme.onPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipes',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Picker-only body, modifiers & controller',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onPrimary.withValues(alpha: 0.88),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: colorScheme.onPrimary.withValues(alpha: 0.85),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoTile extends StatelessWidget {
  const _DemoTile({
    required this.icon,
    required this.title,
    required this.colorScheme,
    required this.onTap,
    this.subtitle,
    this.trailing = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.55),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.outline,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Selected: ${selectedDate.month}/${selectedDate.year}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          Expanded(
            child: CupertinoDateSelectorWidget.monthYear(
              initialDateTime: selectedDate,

              minDateTime: DateTime(DateTime.now().year - 2, 1),
              maxDateTime: DateTime(DateTime.now().year + 100, 12),
              theme: kExampleCupertinoPickerTheme,
              onChanged: (DateTime d) {
                setState(() => selectedDate = d);
              },
            ),
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
            enableHapticFeedback: true,
            theme: kExampleCupertinoPickerTheme,
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
