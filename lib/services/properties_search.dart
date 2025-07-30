import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../Models/Properties/Properties.dart';

Future<List<Property>> loadProperties() async {
  try {
    final String jsonString =
    await rootBundle.loadString('lib/assets/properties.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Property.fromJson(json)).toList();
  } catch (e) {
    debugPrint('Error loading properties: $e');
    return [];
  }
}

List<Property> filterPropertiesBySearch(List<Property> properties, String query) {
  if (query.isEmpty) return properties;

  final queryLower = query.toLowerCase();
  return properties.where((prop) {
    final addr = prop.address;
    return addr.street.toLowerCase().contains(queryLower) ||
        addr.city.toLowerCase().contains(queryLower) ||
        addr.state.toLowerCase().contains(queryLower) ||
        addr.zipCode.toLowerCase().contains(queryLower) ||
        prop.classification.toLowerCase().contains(queryLower);
  }).toList();
}

List<Property> filterPropertiesWithAdvancedFilters(
    List<Property> properties,
    Map<String, dynamic> filters,
    ) {
  final zip = filters['zipCode']?.toString().trim();
  final status = filters['status']?.toString().trim();
  final classification = filters['classification']?.toString().toLowerCase().trim();

  final minScore = (filters['minScore'] as num?)?.toDouble();
  final maxScore = (filters['maxScore'] as num?)?.toDouble();
  final minSqft = (filters['minSqft'] as int?) == 0 ? null : filters['minSqft'] as int?;
  final maxSqft = (filters['maxSqft'] as int?) == 0 ? null : filters['maxSqft'] as int?;
  final minPrice = (filters['minPrice'] as int?) == 0 ? null : filters['minPrice'] as int?;
  final maxPrice = (filters['maxPrice'] as int?) == 0 ? null : filters['maxPrice'] as int?;
  final minBeds = (filters['minBedrooms'] as int?) == 0 ? null : filters['minBedrooms'] as int?;
  final maxBeds = (filters['maxBedrooms'] as int?) == 0 ? null : filters['maxBedrooms'] as int?;
  final minBaths = (filters['minBathrooms'] as int?) == 0 ? null : filters['minBathrooms'] as int?;
  final maxBaths = (filters['maxBathrooms'] as int?) == 0 ? null : filters['maxBathrooms'] as int?;
  final minArea = (filters['minArea'] as int?) == 0 ? null : filters['minArea'] as int?;
  final maxArea = (filters['maxArea'] as int?) == 0 ? null : filters['maxArea'] as int?;

  return properties.where((prop) {
    final matchesZip = zip == null || zip.isEmpty || prop.address.zipCode == zip;
    final matchesStatus = status == null || status.isEmpty || prop.status.toLowerCase() == status.toLowerCase();
    final matchesClassification = classification == null || classification.isEmpty || prop.classification.toLowerCase() == classification;

    final matchesScore = (minScore == null || prop.score >= minScore) &&
        (maxScore == null || prop.score <= maxScore);

    final matchesSqft = (minSqft == null || prop.sqft >= minSqft) &&
        (maxSqft == null || prop.sqft <= maxSqft);

    final matchesPrice = (minPrice == null || prop.arv >= minPrice) &&
        (maxPrice == null || prop.arv <= maxPrice);

    final matchesBeds = (minBeds == null || prop.beds >= minBeds) &&
        (maxBeds == null || prop.beds <= maxBeds);

    final matchesBaths = (minBaths == null || prop.baths >= minBaths) &&
        (maxBaths == null || prop.baths <= maxBaths);

    final matchesArea = (minArea == null || prop.sqft >= minArea) &&
        (maxArea == null || prop.sqft <= maxArea);

    return matchesZip &&
        matchesStatus &&
        matchesClassification &&
        matchesScore &&
        matchesSqft &&
        matchesPrice &&
        matchesBeds &&
        matchesBaths &&
        matchesArea;
  }).toList();
}



// List<Property> filterRevealedProperties(List<Property> properties) {
//   return properties.where((prop) => prop.revealed == true).toList();
// }
