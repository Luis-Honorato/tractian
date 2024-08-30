import 'package:flutter/material.dart';
import 'package:tractian/node/domain/entities/company.dart';
import 'package:tractian/node/presentation/pages/assets_page.dart';
import 'package:tractian/theme/theme_colors.dart';
import 'package:tractian/utils/tractian_icons.dart';

class CompanyWidget extends StatelessWidget {
  final Company company;
  const CompanyWidget({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AssetsPage(
              companyId: company.id,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ThemeColors.bluePrimary,
        ),
        height: 76,
        child: Row(
          children: [
            const SizedBox(width: 30),
            const Icon(
              TractianIcons.company,
              size: 26,
              color: ThemeColors.white,
            ),
            const SizedBox(width: 15),
            Text(
              '${company.name} Unit',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
