import 'package:flutter/material.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and title
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
                    // Title
                    const Text(
                      'Rating',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Rating cards
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildRatingCard(
                      name: 'Muhammad Ali',
                      date: '23 Dec 2023',
                      imageAsset: 'assets/driver_Side/muhammad.jpg',
                      rating: 4.5,
                      comment:
                          'Awesome passenger! Super friendly and very prompt. Would love to drive again!',
                    ),
                    const SizedBox(height: 8),
                    _buildRatingCard(
                      name: 'Ismael Asliyeff',
                      date: '20 Dec 2023',
                      imageAsset: 'assets/driver_Side/ismael.jpg',
                      rating: 4.9,
                      comment:
                          'Awesome passenger! Super friendly and very prompt. Would love to drive again!',
                      avatarBackgroundColor: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    _buildRatingCard(
                      name: 'Harry Thomas',
                      date: '20 Dec 2023',
                      imageAsset: 'assets/driver_Side/harry.jpg',
                      rating: 4.5,
                      comment:
                          'Awesome passenger! Super friendly and very prompt. Would love to drive again!',
                      avatarBackgroundColor: Colors.amber,
                    ),
                    const SizedBox(height: 8),
                    _buildRatingCard(
                      name: 'Sophia Williams',
                      date: '20 Dec 2023',
                      imageAsset: 'assets/driver_Side/sophia.jpg',
                      rating: 3.5,
                      comment:
                          'Awesome passenger! Super friendly and very prompt. Would love to drive again!',
                    ),
                    const SizedBox(height: 8),
                    _buildRatingCard(
                      name: 'Precious Clinton',
                      date: '19 Dec 2023',
                      imageAsset: 'assets/driver_Side/precious.jpg',
                      rating: 5.0,
                      comment:
                          'Awesome passenger! Super friendly and very prompt. Would love to drive again!',
                      avatarBackgroundColor: Colors.brown,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingCard({
    required String name,
    required String date,
    required String imageAsset,
    required double rating,
    required String comment,
    Color? avatarBackgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarBackgroundColor ?? Colors.grey.shade300,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                imageAsset,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 32,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Rating content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and date
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Rating stars
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor()
                              ? Icons.star
                              : (index == rating.floor() && rating % 1 > 0)
                              ? Icons.star_half
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Comment
                Text(
                  comment,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
