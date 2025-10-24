import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';

class FindMerchantsScreen extends StatefulWidget {
  const FindMerchantsScreen({super.key});

  @override
  State<FindMerchantsScreen> createState() => _FindMerchantsScreenState();
}

class _FindMerchantsScreenState extends State<FindMerchantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Plumbing Supplies',
    'Electrical',
    'Tools',
    'Safety Equipment',
    'Parts & Spares',
  ];

  final List<Merchant> _merchants = [
    Merchant(
      name: 'PlumbCenter',
      category: 'Plumbing Supplies',
      distance: '0.5 miles',
      rating: 4.5,
      address: '123 High Street, London',
      phone: '020 1234 5678',
      openNow: true,
    ),
    Merchant(
      name: 'Screwfix',
      category: 'Tools',
      distance: '1.2 miles',
      rating: 4.7,
      address: '456 Main Road, London',
      phone: '020 8765 4321',
      openNow: true,
    ),
    Merchant(
      name: 'City Plumbing Supplies',
      category: 'Plumbing Supplies',
      distance: '2.0 miles',
      rating: 4.3,
      address: '789 Park Avenue, London',
      phone: '020 1111 2222',
      openNow: false,
    ),
  ];

  List<Merchant> get _filteredMerchants {
    return _merchants.where((merchant) {
      final matchesCategory = _selectedCategory == 'All' || 
          merchant.category == _selectedCategory;
      final matchesSearch = merchant.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilter(),
          Expanded(
            child: _buildMerchantList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search merchants...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey[100],
          filled: true,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              selectedColor: AppColors.primary.withOpacity(0.2),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMerchantList() {
    final merchants = _filteredMerchants;
    
    if (merchants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No merchants found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: merchants.length,
      itemBuilder: (context, index) {
        return _buildMerchantCard(merchants[index]);
      },
    );
  }

  Widget _buildMerchantCard(Merchant merchant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showMerchantDetails(merchant),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchant.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          merchant.category,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: merchant.openNow
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      merchant.openNow ? 'OPEN' : 'CLOSED',
                      style: TextStyle(
                        color: merchant.openNow ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    merchant.distance,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.star, size: 16, color: Colors.amber[700]),
                  const SizedBox(width: 4),
                  Text(
                    merchant.rating.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                merchant.address,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    merchant.phone,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.directions, color: AppColors.primary),
                    onPressed: () => _getDirections(merchant),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone, color: AppColors.primary),
                    onPressed: () => _callMerchant(merchant),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMerchantDetails(Merchant merchant) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening ${merchant.name} details...')),
    );
  }

  void _getDirections(Merchant merchant) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Getting directions to ${merchant.name}...')),
    );
  }

  void _callMerchant(Merchant merchant) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${merchant.phone}...')),
    );
  }
}

class Merchant {
  final String name;
  final String category;
  final String distance;
  final double rating;
  final String address;
  final String phone;
  final bool openNow;

  Merchant({
    required this.name,
    required this.category,
    required this.distance,
    required this.rating,
    required this.address,
    required this.phone,
    required this.openNow,
  });
}
