import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/drill/introduction.dart';
import 'package:booqs_mobile/components/drill/order_select_form.dart';
import 'package:booqs_mobile/components/drill/solved_quiz_list_view.dart';
import 'package:booqs_mobile/components/drill/status_tabs.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillSolvedPage extends ConsumerWidget {
  const DrillSolvedPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(drillSolvedPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const DrillIntroduction(),
              const DrillOrderSelectForm(type: 'solved'),
              const SizedBox(height: 40),
              const DrillStatusTabs(
                selected: 'solved',
              ),
              const SizedBox(height: 32),
              DrillSolvedQuizListView(
                key: UniqueKey(),
                order: ref.watch(drillOrderProvider),
              ),
              const SizedBox(height: 160),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
