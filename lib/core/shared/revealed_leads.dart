import '../../Models/Properties/Properties.dart';

List<Property> revealedLeads = [];

List<Property> filterRevealedProperties(List<Property> allProps) {
  return allProps.where((prop) => prop.revealed == true).toList();
}
