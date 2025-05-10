import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryFilter({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  final List<Map<String, String>> categories = const [
    {'name': 'General', 'value': 'general'},
    {'name': 'Business', 'value': 'business'},
    {'name': 'Technology', 'value': 'technology'},
    {'name': 'Sports', 'value': 'sports'},
    {'name': 'Entertainment', 'value': 'entertainment'},
    {'name': 'Health', 'value': 'health'},
    {'name': 'Science', 'value': 'science'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(category['name']!),
              onSelected: (selected) {
                if (selected) {
                  onCategorySelected(category['value']!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}