import 'package:flutter/material.dart';

class RoleSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const RoleSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final roles = ["Étudiant", "Professeur", "Administrateur"];

    return Row(
      children: List.generate(roles.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                roles[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      selectedIndex == index ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
