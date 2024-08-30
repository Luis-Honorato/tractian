import 'package:flutter/material.dart';
import 'package:tractian/node/domain/entities/company.dart';
import 'package:tractian/node/presentation/widgets/company_widget.dart';

class CompaniesList extends StatelessWidget {
  final List<Company> companies;
  const CompaniesList({
    super.key,
    required this.companies,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(18),
        child: CompanyWidget(company: companies[index]),
      ),
    );
  }
}
