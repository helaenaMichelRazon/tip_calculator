import 'package:flutter/material.dart';

void main() {
  runApp(const TipApp());
}

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Berry Sweet Tips',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE84370),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) {
  return double.tryParse(input.trim());
}

({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController = TextEditingController();

  int _selectedPercent = 15;

  static const Color pink = Color(0xFFE84370);
  static const Color lightPink = Color(0xFFFFDCE8);
  static const Color darkRed = Color(0xFF922344);
  static const Color cream = Color(0xFFFFFBF8);

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  void _resetCalculator() {
    setState(() {
      _billController.clear();
      _selectedPercent = 15;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(_billController.text);

    final result = bill != null && bill >= 0
        ? computeTip(bill, _selectedPercent)
        : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0F5),
        foregroundColor: darkRed,
        centerTitle: true,
        title: const Text(
          'Berry Sweet Tips 🍓',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFA9C4),
                      Color(0xFFE84370),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 45,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'A little extra love!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Calculate your tip the sweet way',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: lightPink,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🧾  Bill Amount',
                      style: TextStyle(
                        color: darkRed,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _billController,
                      keyboardType:
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your bill',
                        prefixText: '₱ ',
                        prefixStyle: const TextStyle(
                          color: pink,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: lightPink.withOpacity(0.35),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                '💗  Choose your tip',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkRed,
                ),
              ),

              const SizedBox(height: 12),

              SegmentedButton<int>(
                segments: const [
                  ButtonSegment<int>(
                    value: 10,
                    label: Text('10%'),
                  ),
                  ButtonSegment<int>(
                    value: 15,
                    label: Text('15%'),
                  ),
                  ButtonSegment<int>(
                    value: 20,
                    label: Text('20%'),
                  ),
                ],
                selected: {_selectedPercent},
                onSelectionChanged: (selection) {
                  setState(() {
                    _selectedPercent = selection.first;
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.resolveWith<Color>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return pink;
                      }
                      return cream;
                    },
                  ),
                  foregroundColor:
                  WidgetStateProperty.resolveWith<Color>(
                        (states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return darkRed;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: lightPink,
                    width: 2,
                  ),
                ),
                child: result == null
                    ? const Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: pink,
                      size: 45,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter a valid amount',
                      style: TextStyle(
                        color: darkRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    const Text(
                      'Your sweet results',
                      style: TextStyle(
                        color: darkRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: lightPink.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: pink,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Tip Amount',
                              style: TextStyle(
                                color: darkRed,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            '₱${result.tip.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: pink,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: pink,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'TOTAL AMOUNT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₱${result.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _resetCalculator,
                icon: const Icon(Icons.refresh),
                label: const Text('Start Over'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: darkRed,
                  side: const BorderSide(color: pink),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Made by Helaena Michel Razon♡',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkRed,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}