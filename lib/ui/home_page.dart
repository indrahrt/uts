import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/product_card.dart';
import '../widgets/review_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    "assets/images/hero1.jpg",
    "assets/images/hero2.jpg",
    "assets/images/hero3.jpeg",
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ==========================
      //     FIX SCROLLING DISINI
      // ==========================
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =======================
            //      HERO SECTION
            // =======================
            SizedBox(
              height: 450,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: _images
                        .map((path) => _buildHeroImage(path))
                        .toList(),
                  ),

                  // HEADER
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Sewakeun",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),

                          // Search bar
                          Container(
                            height: 40,
                            width: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.black54),
                                SizedBox(width: 8),
                                Text(
                                  "Cari",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 20),
                          const Icon(Icons.shopping_cart, color: Colors.white),
                        ],
                      ),
                    ),
                  ),

                  // Text + CTA
                  Positioned(
                    right: 40,
                    top: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Never stop exploring",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Dapatkan perlengkapan Anda hari ini",
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            " Penyewaan alat camping →",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Indicator
                  Positioned(
                    bottom: 20,
                    right: 40,
                    child: Row(
                      children: List.generate(_images.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: _circleIndicator(_currentPage == index),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // =======================
            //      PRODUCT SECTIONS
            // =======================
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildSection(title: "Tenda", products: _tendaProduk()),
                  _buildSection(
                    title: "Sleeping Bags",
                    products: _sleepingBagsProduk(),
                  ),
                  _buildSection(title: "Carrier ", products: _carrierProduk()),
                  _buildSection(title: "Sepatu", products: _shoesProduk()),
                  _buildSection(
                    title: "Alat Masak",
                    products: _cookingProduk(),
                  ),
                  _buildSection(title: "Lampu", products: _lampProduk()),
                  const ReviewSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  //                PRODUCT SECTION BUILDER
  // ====================================================

  Widget _buildSection({
    required String title,
    required List<Widget> products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: ListView(scrollDirection: Axis.horizontal, children: products),
        ),
      ],
    );
  }

  // ====================================================
  //                PRODUCT DATA
  // ====================================================

  List<Widget> _tendaProduk() {
    return [
      ProductCard(
        image: "assets/images/tenda1.jpg",
        title: "Tenda Gunung",
        price: 200_000,
        discountPrice: 150_000,
      ),
      ProductCard(
        image: "assets/images/tenda2.jpg",
        title: "Tenda Camping",
        price: 175_000,
        discountPrice: 145_000,
      ),
      ProductCard(
        image: "assets/images/tenda3.png",
        title: "Tenda Keluarga",
        price: 300_000,
        discountPrice: 250_000,
      ),
      ProductCard(
        image: "assets/images/tenda4.jpg",
        title: "Tenda Dome",
        price: 225_000,
        discountPrice: 200_000,
      ),
      ProductCard(
        image: "assets/images/tenda5.jpg",
        title: "Tenda Tunnel",
        price: 245_000,
        discountPrice: 190_000,
      ),
    ];
  }

  List<Widget> _sleepingBagsProduk() {
    return [
      ProductCard(
        image: "assets/images/sleeping_bag1.png",
        title: "Sleeping Bag Hangat",
        price: 75_000,
        discountPrice: 60_000,
      ),
      ProductCard(
        image: "assets/images/sleeping_bag2.jpg",
        title: "Sleeping Bag Lembut",
        price: 75_000,
        discountPrice: 55_000,
      ),
    ];
  }

  List<Widget> _carrierProduk() {
    return [
      ProductCard(
        image: "assets/images/carrier1.jpg",
        title: "Carrier 40L",
        price: 85_000,
        discountPrice: 75_000,
      ),
      ProductCard(
        image: "assets/images/carrier2.jpg",
        title: "Carrier 60L",
        price: 180_000,
        discountPrice: 150_000,
      ),
    ];
  }

  List<Widget> _shoesProduk() {
    return [
      ProductCard(
        image: "assets/images/sepatu.jpg",
        title: "Sepatu Hiking",
        price: 50_000,
        discountPrice: 45_000,
      ),
    ];
  }

  List<Widget> _cookingProduk() {
    return [
      ProductCard(
        image: "assets/images/panci.jpg",
        title: "Panci",
        price: 50_000,
        discountPrice: 30_000,
      ),
      ProductCard(
        image: "assets/images/kompor.jpg",
        title: "Set Alat Masak",
        price: 200_000,
        discountPrice: 150_000,
      ),
    ];
  }

  List<Widget> _lampProduk() {
    return [
      ProductCard(
        image: "assets/images/lampu1.jpg",
        title: "Lampu Camping",
        price: 75_000,
        discountPrice: 65_000,
      ),
      ProductCard(
        image: "assets/images/lampu2.webp",
        title: "Lampu Jelajah",
        price: 75_000,
        discountPrice: 60_000,
      ),
    ];
  }

  // ====================================================
  //          HERO IMAGE + INDICATOR
  // ====================================================

  Widget _buildHeroImage(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _circleIndicator(bool active) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? Colors.orangeAccent : Colors.white54,
        shape: BoxShape.circle,
      ),
    );
  }
}
