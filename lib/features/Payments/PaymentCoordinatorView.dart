import 'package:flutter/material.dart';
import '../../core/AppTheme/AppColors.dart';
import 'components/PaymentView.dart';
import 'components/add_reveal.dart';
import 'components/invoices_view.dart';


class PaymentsCoordinatorView extends StatefulWidget {
  const PaymentsCoordinatorView({super.key});

  @override
  State<PaymentsCoordinatorView> createState() => _PaymentsCoordinatorViewState();
}

class _PaymentsCoordinatorViewState extends State<PaymentsCoordinatorView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> get _pages => [
    PaymentsView(
      onAddRevealsTap: () {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    ),
    const AddRevealsView(),
    const InvoicesView(),
  ];


  final List<String> _titles = ['Payments', 'Add Reveals', 'Invoices'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildSliderTabs(),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_titles.length, (index) {
          final isSelected = index == _currentPage;
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _titles[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? CustomColors.secondary
                        : Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: isSelected ? 24 : 0,
                  color: isSelected ? CustomColors.secondary : Colors.transparent,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }


}
