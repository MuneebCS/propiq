import 'package:flutter/material.dart';
import '../../Models/Properties/Properties.dart';
import '../../core/AppTheme/AppColors.dart';
import '../../core/shared/revealed_leads.dart';
import '../../services/properties_search.dart';
import '../../widgets/AppTextField.dart';
import '../Leads/components/LeadCard.dart';
import 'components/FilterBottomSheet.dart';
import 'components/MapSectionView.dart';
import 'components/PropertyCard/DetailedPropertyCard.dart';
import 'components/PropertyCard/ExclusivePropertyCard.dart';
import 'components/PropertyCard/LockedRevealPropertyCard.dart';
import 'components/PropertyCard/RevealedPropertyCard.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  _MapSearchViewState createState() => _MapSearchViewState();
}

class _MapSearchViewState extends State<MapsView> {
  final TextEditingController _addressController = TextEditingController();
  Map<String, dynamic> _currentFilters = {};
  List<Property> allLeads = [];
  List<Property> _allProperties = [];
  List<Property> _filteredProperties = [];

  // ✅ Add this to track revealed state locally
  final Set<String> _revealedPropertyIds = {};

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    _allProperties = await loadProperties();
    revealedLeads = filterRevealedProperties(_allProperties);
    setState(() {
      allLeads = revealedLeads;
      _filteredProperties = [];
    });
  }

  void _filterBySearch(String query) {
    final filtered = filterPropertiesBySearch(_allProperties, query);
    setState(() {
      _filteredProperties = filtered;
    });
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _currentFilters = filters;
      _filteredProperties = filterPropertiesWithAdvancedFilters(_allProperties, filters);
    });
  }

  // ✅ Update reveal method to use local tracking set
  void _revealProperty(Property p) {
    setState(() {
      if (!revealedLeads.contains(p)) {
        revealedLeads.add(p);
      }
      _revealedPropertyIds.add(p.id.toString()); // ✅ Convert to String
      // Use property.id or another unique identifier
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasProperties = _filteredProperties.isNotEmpty || _allProperties.isNotEmpty;
    final Property? firstProperty = _filteredProperties.isNotEmpty
        ? _filteredProperties.first
        : _allProperties.isNotEmpty
        ? _allProperties.first
        : null;

    final double lat = firstProperty?.location.latitude ?? 37.7749;
    final double lng = firstProperty?.location.longitude ?? -122.4194;

    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSearchAndFilter(),
                const SizedBox(height: 4),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 500,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: MapSectionView(
                    lat: lat,
                    long: lng,
                  ),
                ),
                const SizedBox(height: 12),
                _buildPropertyList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppTextField(
        label: 'Address / City / State',
        hintText: 'Enter location',
        controller: _addressController,
        onChanged: (value) => _filterBySearch(value),
        suffixIcon: IconButton(
          icon: const Icon(Icons.filter_alt_rounded, color: CustomColors.secondary),
          onPressed: _showFilterSheet,
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(
        onApply: _applyFilters,
        initialFilters: _currentFilters,
      ),
    );
  }

  Widget _buildPropertyList() {
    if (_filteredProperties.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("No properties to display", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredProperties.length,
      itemBuilder: (context, index) {
        final property = _filteredProperties[index];
        return _buildPropertyCard(property);
      },
    );
  }

  Widget _buildPropertyCard(Property property) {
    final isRevealedLocally = _revealedPropertyIds.contains(property.id.toString());
    if (property.revealed == true || isRevealedLocally) {
      return DetailedPropertyCard(property: property);
    }

    if (property.exclusive == true) {
      return ExclusivePropertyCard(property: property);
    }

    if ((property.revealed != true || property.revealed == null) &&
        (property.revealCount != null && property.revealCount! >= 30)) {
      return LockedRevealPropertyCard(property: property);
    }

    return RevealedPropertyCard(
      property: property,
      onReveal: _revealProperty,
    );
  }
}
