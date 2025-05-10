import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;

  const CustomSearchBar({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          // Debounce the search
          Future.delayed(const Duration(milliseconds: 500), () {
            onChanged(value);
          });
        },
        decoration: InputDecoration(
          hintText: 'Search news...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}