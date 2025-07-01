import 'package:flutter/material.dart';



class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and wallet title
              Row(
                children: [
                  // Back button in square with purple border
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.purple,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Wallet title
                  const Text(
                    'Wallet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Total Amount Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2D0A53), // Deep purple
                      const Color(0xFF8B7500), // Gold/amber
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$200.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  // Send To Bank Button
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBB1E5), // Light purple
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Send To Bank',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Add Money Button
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAA8FD8), // Medium purple
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Add Money',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Recent Transactions Title
              const Text(
                'Recent Transaction',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Transaction List
              Expanded(
                child: ListView(
                  children: [
                    // Transaction 1
                    buildTransactionItem(
                      title: 'Send to bank',
                      date: 'Today | 10:30 AM',
                      amount: '\$24.00',
                      isPositive: false,
                    ),
                    buildDivider(),

                    // Transaction 2
                    buildTransactionItem(
                      title: 'Added to wallet',
                      date: '23Jan 2025 | 10:30 AM',
                      amount: '\$40.00',
                      isPositive: true,
                    ),
                    buildDivider(),

                    // Transaction 3
                    buildTransactionItem(
                      title: 'Received for ride',
                      date: '3 Jan 2025 | 10:30 AM',
                      amount: '\$30.00',
                      isPositive: true,
                    ),
                    buildDivider(),

                    // Transaction 4
                    buildTransactionItem(
                      title: 'Received for ride',
                      date: '24 Dec 2025 | 10:30 AM',
                      amount: '\$20.00',
                      isPositive: true,
                    ),
                    buildDivider(),

                    // Transaction 5
                    buildTransactionItem(
                      title: 'Send to bank',
                      date: '4 Dec 2025 | 10:30 AM',
                      amount: '\$50.00',
                      isPositive: false,
                    ),
                    buildDivider(),

                    // Transaction 6
                    buildTransactionItem(
                      title: 'Added to wallet',
                      date: '1 Dec 2025 | 10:30 AM',
                      amount: '\$25.00',
                      isPositive: true,
                    ),
                    buildDivider(),

                    // Transaction 7
                    buildTransactionItem(
                      title: 'Added to wallet',
                      date: '1 Dec 2025 | 10:30 AM',
                      amount: '\$20.00',
                      isPositive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build transaction item
  Widget buildTransactionItem({
  required String title,
  required String date,
  required String amount,
  required bool isPositive,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        // Left side - Title and date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF2D0A53), Color(0xFF8B7500)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Required for ShaderMask
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),

        // Right side - Amount
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isPositive ? Colors.green : Colors.red,
          ),
        ),
      ],
    ),
  );
}
  // Helper method to build divider
  Widget buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFEEEEEE),
    );
  }
}