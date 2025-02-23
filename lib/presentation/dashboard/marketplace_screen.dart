import 'package:e_waste/core/utils/custom_app_bar.dart';
import 'package:e_waste/viewmodels/marketplace_viewmodel.dart';
import 'package:e_waste/widgets/custom_text.dart';
import 'package:e_waste/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class MarketplaceScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MarketplaceScreen({super.key, required this.scaffoldKey});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final List<ProductItem> _products = [
    ProductItem(
      imageUrl: 'https://i.imgur.com/vf2NbUQ.png',
      price: 250,
      title: 'Old Mobile Phones',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/dVlbWoc.png',
      price: 800,
      title: 'Electronic Parts',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/V3i9hGV.png',
      price: 600,
      title: 'CRT Monitors',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/EfIgN8f.png',
      price: 1000,
      title: 'AC Unit',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/vf2NbUQ.png',
      price: 250,
      title: 'Old Mobile Phones',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/dVlbWoc.png',
      price: 800,
      title: 'Electronic Parts',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/V3i9hGV.png',
      price: 600,
      title: 'CRT Monitors',
    ),
    ProductItem(
      imageUrl: 'https://i.imgur.com/EfIgN8f.png',
      price: 1000,
      title: 'AC Unit',
    ),
  ];
  int _selectedTabIndex = 0;
  final List<String> _tabs = [
    'All',
    'Electronics',
    'Electronics',
    'More',
    'More'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          /// App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0),
            child: customAppBar(
              isHome: false,
              title: "Marketplace",
              rank: '12',
              points: '40',
              scaffoldKey: widget.scaffoldKey,
              prf: const Image(image: AssetImage("assets/prf.png")),
              context: context,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          /// Search Bar
          buildSearchBar(),

          /// Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 2),
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _tabs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tab = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: _selectedTabIndex == index,
                      label: CustomText(
                        textName: tab,
                        textColor: _selectedTabIndex == index
                            ? Colors.white
                            : AppColors.green,
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: _selectedTabIndex == index
                              ? Colors.transparent
                              : AppColors.green,
                        ),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          /// Product Grid
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return marketplaceView()
                    .buildProductCard(product: _products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
