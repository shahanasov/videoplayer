import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/core/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:noviindusvideoapp/providers/home_provider.dart';

class CategorySelectionWidget extends StatelessWidget {
  const CategorySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (homeProvider.isLoadingCategories) {
          return Center(child: CircularProgressIndicator());
        }

        final availableCategories = homeProvider.categories;
        final selectedCategories = homeProvider.selectedCategories;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: availableCategories.map((category) {
            bool isSelected = selectedCategories.contains(category);

            return GestureDetector(
              onTap: () {
                homeProvider.toggleCategorySelection(category,context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.border : AppColors.secondary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  category.title, // Using title from Category model
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
