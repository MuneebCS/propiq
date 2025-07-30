import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../core/utils/device_utils.dart';
import '../../Models/Properties/Properties.dart';
import '../../core/shared/revealed_leads.dart';
import '../../services/properties_search.dart';
import '../../widgets/AppTextField.dart';
import '../../widgets/AppButton.dart';
import '../Maps/components/FilterBottomSheet.dart';
import 'components/LeadCard.dart';

class LeadsView extends StatefulWidget {
  const LeadsView({super.key});

  @override
  State<LeadsView> createState() => _LeadsViewState();
}

class _LeadsViewState extends State<LeadsView> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  String selectedCountry = 'All Countries';
  String selectedSort = 'Sort by Score';

  final List<String> countries = ['All Countries', 'USA'];
  final List<String> sortOptions = [
    'Sort by Score',
    'Score (High to Low)',
    'Score (Low to High)',
  ];

  List<Property> allLeads = [];


  @override
  void initState() {
    super.initState();
    setState(() {
      allLeads = revealedLeads;
    });
  }


  List<Property> get filteredLeads {
    return allLeads.where((lead) {
      final searchText = _addressController.text.toLowerCase();

      final addressMatch =
          lead.address.street.toLowerCase().contains(searchText) ||
              lead.address.city.toLowerCase().contains(searchText) ||
              lead.address.state.toLowerCase().contains(searchText);

      final scoreMatch = double.tryParse(searchText) != null
          ? lead.score.toStringAsFixed(1) == double.parse(searchText).toStringAsFixed(1)
          : true;

      final zipMatch = _zipCodeController.text.isEmpty ||
          lead.address.zipCode.contains(_zipCodeController.text);

      final countryMatch = selectedCountry == 'All Countries' ||
          lead.address.country == selectedCountry;

      return (addressMatch || scoreMatch) && zipMatch && countryMatch;
    }).toList()
      ..sort((a, b) {
        if (selectedSort == 'Score (High to Low)') {
          return b.score.compareTo(a.score);
        } else if (selectedSort == 'Score (Low to High)') {
          return a.score.compareTo(b.score);
        }
        return 0;
      });
  }

  int get averagePrice => filteredLeads.isEmpty
      ? 0
      : (filteredLeads.map((e) => e.arv).reduce((a, b) => a + b) ~/ filteredLeads.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: allLeads.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLeadsCountCard(filteredLeads.length),
            const SizedBox(height: 12),
            _buildAveragePriceCard(averagePrice),
            const SizedBox(height: 20),
            _buildSearchAndFilter(),
            const SizedBox(height: 20),
            ...filteredLeads.map((lead) => LeadCard(
              propertyAddress:
              '${lead.address.street}, ${lead.address.city}, ${lead.address.state}, ${lead.address.zipCode}, ${lead.address.country}',
              owner: lead.seller.name,
              email: lead.seller.email,
              phone: lead.seller.phones.join(", "),
              status: lead.status,
              price: lead.arv,
              beds: lead.beds,
              baths: lead.baths,
              sqft: lead.sqft,
              score: lead.score,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadsCountCard(int leadsCount) {
    return Card(
      color: CustomColors.primary,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Leads Count',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              '$leadsCount',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: CustomColors.secondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAveragePriceCard(int price) {
    return Card(
      color: CustomColors.primary,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Average Price',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              '\$$price',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: CustomColors.secondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Address / City / State',
          hintText: 'Enter location',
          controller: _addressController,
          onChanged: (_) => setState(() {}),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_alt_rounded, color: CustomColors.secondary),
            onPressed: () => _showFilterSheet(),
          ),
        ),
      ],
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                label: 'Zip Code',
                hintText: 'Enter zip code',
                controller: _zipCodeController,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: _dropdownDecoration('Country'),
                dropdownColor: CustomColors.primary,
                value: selectedCountry,
                iconEnabledColor: CustomColors.secondary,
                style: TextStyle(color: CustomColors.secondary),
                items: countries.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country, style: TextStyle(color: CustomColors.secondary)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedCountry = val!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: _dropdownDecoration('Sort by Score'),
                dropdownColor: CustomColors.primary,
                value: selectedSort,
                iconEnabledColor: CustomColors.secondary,
                style: TextStyle(color: CustomColors.secondary),
                items: sortOptions.map((s) {
                  return DropdownMenuItem(
                    value: s,
                    child: Text(s, style: TextStyle(color: CustomColors.secondary)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedSort = val!),
              ),
              const SizedBox(height: 20),
              AppButton(
                text: 'Apply Filters',
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: CustomColors.secondary),
      filled: true,
      fillColor: CustomColors.primary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomColors.secondary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomColors.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomColors.secondary, width: 2),
      ),
    );
  }
}
