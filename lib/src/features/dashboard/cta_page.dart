import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/app_barrel.dart';
import '../../global/ui/ui_barrel.dart';
import '../../global/ui/widgets/fields/custom_textfield.dart';
import 'shared.dart';

class CTAPage extends StatelessWidget {
  const CTAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                Ui.boxHeight(24),
                MatchScenarioWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}