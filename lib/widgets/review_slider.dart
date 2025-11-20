// simpan file ini di: lib/widgets/review_slider.dart

import 'package:flutter/material.dart';
import 'dart:async';

class ReviewSlider extends StatefulWidget {
  const ReviewSlider({super.key});

  @override
  State<ReviewSlider> createState() => _ReviewSliderState();
}

class _ReviewSliderState extends State<ReviewSlider> {
  final PageController _controller = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _dummyReviews = [
    "Pelayanan sangat ramah dan cepat!",
    "Barang lengkap dan kualitas bagus banget.",
    "Pengalaman sewa sangat memuaskan, recommended!",
    "Harga terjangkau dan proses mudah.",
    "Tempat sewa terbaik, bakal balik lagi!",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        if (_currentPage < _dummyReviews.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),

        // Bar input komentar (tanpa warna, shadow lebih tebal)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // lebih tebal
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.edit, color: Colors.black87, size: 20),
                SizedBox(width: 10),
                Text(
                  "Tulis komentar...",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Review slider (tetap orange gradient)
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _controller,
            itemCount: _dummyReviews.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _startAutoScroll();
            },
            itemBuilder: (context, index) {
              final isActive = index == _currentPage;

              return AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: isActive ? 1 : 0.6,
                child: Transform.scale(
                  scale: isActive ? 1 : 0.95,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isActive
                            ? [Colors.orange.shade200, Colors.orange.shade50]
                            : [Colors.orange.shade50, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(isActive ? 0.2 : 0.08),
                          blurRadius: isActive ? 10 : 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      _dummyReviews[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _dummyReviews.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == index ? 14 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.orange : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}