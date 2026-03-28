import 'package:cupertino_date_selector/cupertino_date_selector.dart';
import 'package:flutter/material.dart';

/// Demo patterns: picker-only layout, modifiers, and external controller.
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  int _pickerOnlyIndex = 1;
  final CupertinoDateSelectorController _yearController =
      CupertinoDateSelectorController();

  late final CupertinoDateSelector _itemsConfig;

  @override
  void initState() {
    super.initState();
    _itemsConfig = CupertinoDateSelector.items(
      items: const [
        Text('Small'),
        Text('Medium'),
        Text('Large'),
      ],
      selectedItemIndex: _pickerOnlyIndex,
      theme: const CupertinoDateSelectorThemeData(),
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Picker only', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Use CupertinoDateSelectorPickerBody inside your own sheet or card.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Card(
            child: SizedBox(
              height: 200,
              child: CupertinoDateSelectorPickerBody(
                selector: _itemsConfig,
                value: _pickerOnlyIndex,
                onChanged: (v) => setState(() => _pickerOnlyIndex = v as int),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Controller + jumpTo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton(
                onPressed: () {
                  final DateTime y = (_yearController.value as DateTime?) ??
                      DateTime(2020);
                  _yearController.jumpTo(DateTime(y.year - 1));
                  setState(() {});
                },
                child: const Text('−1 year'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  final DateTime y = (_yearController.value as DateTime?) ??
                      DateTime(2020);
                  _yearController.jumpTo(DateTime(y.year + 1));
                  setState(() {});
                },
                child: const Text('+1 year'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 240,
            child: CupertinoDateSelectorWidget.year(
              initialDateTime: DateTime(2020),
              minDateTime: DateTime(2015),
              maxDateTime: DateTime(2030),
              controller: _yearController,
              onChanged: (_) => setState(() {}),
              onSubmit: (_) {},
              modifiers: const CupertinoDateSelectorModifiers(
                enableHapticFeedback: true,
                semanticsLabel: 'Year picker',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
