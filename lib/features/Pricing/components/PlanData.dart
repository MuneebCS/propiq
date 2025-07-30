class PlanData {
  final String title;
  final String price;
  final String subtitle;
  final List<String> features;
  final String buttonText;
  final bool isPopular;

  const PlanData({
    required this.title,
    required this.price,
    required this.subtitle,
    required this.features,
    this.isPopular = false,
    required this.buttonText,
  });
}
