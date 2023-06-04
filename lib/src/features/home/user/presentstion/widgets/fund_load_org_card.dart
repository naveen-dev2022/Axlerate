import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FundLoadOrgCard extends ConsumerWidget {
  const FundLoadOrgCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.balance,
    required this.icon,
    required this.borderColor,
    required this.textColor,
  });

  final String title;
  final String subtitle;
  final String balance;
  final IconData icon;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 350.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.2,
          color: borderColor,
        ),
        color: const Color(0xffF1EFF8),
      ),
      // * From Card Column
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Icon(
                icon,
                size: 46.0,
                color: textColor,
              ),
              const SizedBox(width: 12.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    balance,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
