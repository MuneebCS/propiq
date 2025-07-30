import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/AppButton.dart';

class LeadEngagementFeedback extends StatefulWidget {
  final VoidCallback onNext;

  const LeadEngagementFeedback({super.key, required this.onNext});

  @override
  State<LeadEngagementFeedback> createState() => _LeadEngagementFeedbackState();
}

class _LeadEngagementFeedbackState extends State<LeadEngagementFeedback> {
  bool? reachedSeller;
  bool? sellerInterested;

  bool get isFormComplete => reachedSeller != null && sellerInterested != null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Lead Engagement Feedback",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildQuestion(
                label: "Did you reach the seller?",
                value: reachedSeller,
                onChanged: (val) => setState(() => reachedSeller = val),
              ),
              const SizedBox(height: 20),
              _buildQuestion(
                label: "Was the seller interested in selling?",
                value: sellerInterested,
                onChanged: (val) => setState(() => sellerInterested = val),
              ),
              const SizedBox(height: 28),
              AppButton(
                text: "Submit Feedback",
                onPressed: isFormComplete ? widget.onNext : null,
                width: 180,
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion({
    required String label,
    required bool? value,
    required Function(bool) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.thumb_up, color: value == true ? Colors.green : Colors.grey),
              onPressed: () {
                onChanged(true);
              },
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: Icon(Icons.thumb_down, color: value == false ? Colors.red : Colors.grey),
              onPressed: () {
                onChanged(false);
              },
            ),
          ],
        ),
      ],
    );
  }


  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomColors.secondary,
        content: const Text('Please review if the numbers are correct'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}




class QuickSurveyForm extends StatefulWidget {
  final VoidCallback onSubmit;

  const QuickSurveyForm({super.key, required this.onSubmit});

  @override
  State<QuickSurveyForm> createState() => _QuickSurveyFormState();
}

class _QuickSurveyFormState extends State<QuickSurveyForm> {
  double _leadQuality = 5;
  String _feedback = '';
  bool? _gotDeals;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Quick Survey",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("How would you rate lead quality?"),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Text("1"),
                    Expanded(
                      child: Slider(
                        value: _leadQuality,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: _leadQuality.round().toString(),
                        activeColor: CustomColors.secondary,
                        onChanged: (value) {
                          setState(() => _leadQuality = value);
                        },
                      ),
                    ),
                    const Text("10"),
                  ],
                ),
                Text(
                  _leadQuality.round().toString(),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary),
                ),

                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Any feedback to improve the platform?"),
                ),
                const SizedBox(height: 8),

                TextField(
                  minLines: 3,
                  maxLines: 5,
                  onChanged: (val) => _feedback = val,
                  decoration: InputDecoration(
                    hintText: "Your feedback...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Have you gotten any deals yet?"),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up, color: _gotDeals == true ? Colors.green : Colors.grey),
                      onPressed: () => setState(() => _gotDeals = true),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.thumb_down, color: _gotDeals == false ? Colors.red : Colors.grey),
                      onPressed: () => setState(() => _gotDeals = false),
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                      text: "Skip",
                      onPressed: () => Navigator.of(context).pop(),
                      isPrimary: false,
                      width: 120,
                      height: 42,
                    ),
                    AppButton(
                      text: "Submit",
                      onPressed: () {
                        debugPrint("Lead Quality: $_leadQuality");
                        debugPrint("Feedback: $_feedback");
                        debugPrint("Got Deals: $_gotDeals");
                        widget.onSubmit();
                      },
                      width: 120,
                      height: 42,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

