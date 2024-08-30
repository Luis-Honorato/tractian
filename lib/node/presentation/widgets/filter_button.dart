import 'package:flutter/material.dart';
import 'package:tractian/theme/theme_colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final bool isSelected;
  final IconData icon;

  const FilterButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap.call(),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(width: 0.2),
        ),
        elevation: 0,
        backgroundColor:
            isSelected ? ThemeColors.bluePrimary : ThemeColors.white,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected
                ? ThemeColors.white
                : Theme.of(context).textTheme.bodySmall?.color,
            size: 18,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: isSelected ? ThemeColors.white : null),
          ),
        ],
      ),
    );
  }
}
