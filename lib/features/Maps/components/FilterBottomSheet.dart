import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/AppButton.dart';
import '../../../widgets/AppTextField.dart';

class FilterBottomSheet extends StatefulWidget {
  final void Function(Map<String, dynamic>) onApply;
  final Map<String, dynamic> initialFilters;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    required this.initialFilters,
  });


  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  int minBedrooms = 0, maxBedrooms = 0;
  int minBathrooms = 0, maxBathrooms = 0;
  int minPrice = 0, maxPrice = 0;
  int minArea = 0, maxArea = 0;

  String? selectedStatus;
  String? selectedSort;
  String? selectedClassification;

  final List<String> statusOptions = ['All Status', 'High', 'Medium', 'Low'];
  final List<String> sortOptions = ['Sort by Score', 'High to Low', 'Low to High'];
  final List<String> classificationOptions = ['All Classification','Residential', 'Commercial', 'Industrial', 'Agricultural'];

  @override
  void initState() {
    super.initState();

    zipCodeController.text = widget.initialFilters['zipCode'] ?? '';
    countryController.text = widget.initialFilters['country'] ?? '';

    selectedSort = widget.initialFilters['sort'];
    selectedStatus = widget.initialFilters['status'];
    selectedClassification = widget.initialFilters['classification'];

    minBedrooms = widget.initialFilters['minBedrooms'] ?? 0;
    maxBedrooms = widget.initialFilters['maxBedrooms'] ?? 0;
    minBathrooms = widget.initialFilters['minBathrooms'] ?? 0;
    maxBathrooms = widget.initialFilters['maxBathrooms'] ?? 0;
    minPrice = widget.initialFilters['minPrice'] ?? 0;
    maxPrice = widget.initialFilters['maxPrice'] ?? 0;
    minArea = widget.initialFilters['minArea'] ?? 0;
    maxArea = widget.initialFilters['maxArea'] ?? 0;
  }


  void _resetFilters() {
    setState(() {
      zipCodeController.clear();
      countryController.clear();
      selectedSort = null;
      selectedStatus = null;
      selectedClassification = null;
      minBedrooms = 0;
      maxBedrooms = 0;
      minBathrooms = 0;
      maxBathrooms = 0;
      minPrice = 0;
      maxPrice = 0;
      minArea = 0;
      maxArea = 0;
    });
  }

  void _applyFilters() {
    final filters = {
      'zipCode': zipCodeController.text.trim(),
      'country': countryController.text.trim(),
      'status': (selectedStatus == 'All Status') ? null : selectedStatus,
      'sort': (selectedSort == 'Sort by Score') ? null : selectedSort,
      'classification': (selectedClassification == 'All Classification') ? null : selectedClassification,
      'minBedrooms': minBedrooms,
      'maxBedrooms': maxBedrooms,
      'minBathrooms': minBathrooms,
      'maxBathrooms': maxBathrooms,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'minArea': minArea,
      'maxArea': maxArea,
    };

    // 🔍 Print debug values to console
    print('Applying Filters:');
    filters.forEach((key, value) {
      print('  $key: $value');
    });

    widget.onApply(filters);
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.primary,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Property Filters",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.secondary,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField("Zip Code", zipCodeController),
              _buildTextField("Country", countryController),
              _buildDropdown("Sort by Score", sortOptions, selectedSort, (value) {
                setState(() => selectedSort = value);
              }),
              _buildDropdown("All Status", statusOptions, selectedStatus, (value) {
                setState(() => selectedStatus = value);
              }),
              _buildDropdown("Classification", classificationOptions, selectedClassification, (value) {
                setState(() => selectedClassification = value);
              }),
              _buildCounterRow("Bedrooms", minBedrooms, maxBedrooms, (min) => setState(() => minBedrooms = min), (max) => setState(() => maxBedrooms = max)),
              _buildCounterRow("Bathrooms", minBathrooms, maxBathrooms, (min) => setState(() => minBathrooms = min), (max) => setState(() => maxBathrooms = max)),
              _buildCounterRow("Price (\$)", minPrice, maxPrice, (min) => setState(() => minPrice = min), (max) => setState(() => maxPrice = max)),
              _buildCounterRow("Building Area (sqft)", minArea, maxArea, (min) => setState(() => minArea = min), (max) => setState(() => maxArea = max)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      isPrimary: true,
                      text: 'Apply Filters',
                      onPressed: _applyFilters,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      isPrimary: false,
                      text: 'Reset Filters',
                      onPressed: _resetFilters,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppTextField(
        label: label,
        hintText: 'Enter $label',
        controller: controller,
      ),
    );
  }

  Widget _buildDropdown(
      String label,
      List<String> options,
      String? selectedValue,
      void Function(String?) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: options.contains(selectedValue) ? selectedValue : null,
        icon: const Icon(Icons.arrow_drop_down, color: CustomColors.secondary),
        dropdownColor: CustomColors.primary,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: CustomColors.primary.withAlpha((0.1 * 255).toInt()),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: CustomColors.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: CustomColors.secondary, width: 2),
          ),
        ),
        style: const TextStyle(color: CustomColors.secondary),
        items: options.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCounterRow(
      String label,
      int minValue,
      int maxValue,
      void Function(int) onMinChanged,
      void Function(int) onMaxChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _buildCounterField("Min", minValue, onMinChanged)),
              const SizedBox(width: 10),
              Expanded(child: _buildCounterField("Max", maxValue, onMaxChanged)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterField(String label, int value, void Function(int) onChanged) {
    final controller = TextEditingController(text: value.toString());
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: CustomColors.primary.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColors.secondary),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (value > 0) onChanged(value - 1);
            },
            icon: const Icon(Icons.remove, color: CustomColors.secondary, size: 20),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: CustomColors.secondary),
              onChanged: (val) {
                final parsed = int.tryParse(val) ?? 0;
                onChanged(parsed < 0 ? 0 : parsed);
              },
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          IconButton(
            onPressed: () => onChanged(value + 1),
            icon: const Icon(Icons.add, color: CustomColors.secondary, size: 20),
          ),
        ],
      ),
    );
  }
}
