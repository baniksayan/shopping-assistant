import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/price_comparison_card.dart';

class AIChatScreen extends StatefulWidget {
  final String? initialQuery;
  const AIChatScreen({Key? key, this.initialQuery}) : super(key: key);

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final List<Map<String, String>> _messages = [];
  // We will store special bot responses with type 'comparison' and payload as necessary

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _ctrl.text = widget.initialQuery!;
      WidgetsBinding.instance.addPostFrameCallback((_) => _sendQuery());
    }
  }

  void _sendQuery() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'from': 'user', 'text': text});
      // Immediately add a short bot text so the user sees a response
      _messages.add({'from': 'bot', 'text': 'Fetching comparison results...'});
      // also add a comparison payload entry (we'll render it specially in the list)
      final results = _mockCompare(text);
      _messages.add({'from': 'bot', 'type': 'comparison', 'payload': '', 'product': text, 'bestIndex': results['best'].toString()});
      // Store results in a temporary map keyed by index in a simple way by appending to a map list.
      // For simplicity we keep the results on this widget instance in a separate field.
      _lastCompareResults = results['data'];
      _ctrl.clear();
    });
  }

  List<Map<String, String>>? _lastCompareResults;

  /// Simple mocked comparator that creates demo results and picks the lowest price as best.
  Map<String, dynamic> _mockCompare(String query) {
    // Mocked store data -- in a real implementation we'd call APIs
    final mock = [
      {'store': 'Amazon', 'price': '₹10,499', 'subtitle': 'Delivered in 2 days'},
      {'store': 'Flipkart', 'price': '₹10,250', 'subtitle': 'Free delivery'},
      {'store': 'Dell', 'price': '₹10,999', 'subtitle': 'Official seller'},
    ];

    // Extract numeric prices to pick the best
    int best = 0;
    int bestVal = 1 << 30;
    for (var i = 0; i < mock.length; i++) {
      final p = mock[i]['price']!.replaceAll(RegExp(r'[^0-9]'), '');
      final val = int.tryParse(p) ?? 0;
      if (val < bestVal) {
        bestVal = val;
        best = i;
      }
    }

    return {'data': mock, 'best': best};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientStart,
        title: const Text('AI Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isUser = m['from'] == 'user';
                if (m['from'] == 'bot' && m['type'] == 'comparison') {
                  // Render the comparison card using the stored last results
                  final product = m['product'] ?? '';
                  final bestIndex = int.tryParse(m['bestIndex'] ?? '0') ?? 0;
                  final data = _lastCompareResults ?? [];
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: PriceComparisonCard(productName: product, results: data, bestIndex: bestIndex),
                    ),
                  );
                }

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primaryBlue : AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      m['text'] ?? '',
                      style: TextStyle(color: isUser ? Colors.white : AppColors.primaryText),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppColors.cardBackground,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    style: TextStyle(color: AppColors.primaryText),
                    decoration: InputDecoration(
                      hintText: 'Compare e.g. "₹10,000 laptop"',
                      hintStyle: TextStyle(color: AppColors.secondaryText),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendQuery(),
                  ),
                ),
                IconButton(
                  onPressed: _sendQuery,
                  icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
