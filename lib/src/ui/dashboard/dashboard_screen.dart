import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gas_man_app/src/ui/find_merchants_screen.dart';
import 'package:gas_man_app/src/ui/invoices_screen.dart';
import 'package:gas_man_app/src/ui/address/address_screen.dart';
import 'package:gas_man_app/src/ui/gas_certificate_flow/customer_page.dart';
import 'package:gas_man_app/src/ui/gas_certificate_flow/jobs_page.dart';
import 'package:gas_man_app/src/ui/gas_pipe_sizing/gas_pipe_sizing_screen.dart';
import 'package:gas_man_app/src/ui/gas_rate_calculator/gas_rate_calculator_screen.dart';
import 'package:gas_man_app/src/ui/record/record_screen.dart';
import 'package:gas_man_app/src/ui/settings/settings_screen.dart';
import 'package:gas_man_app/src/ui/ventilation_screen.dart';
import 'package:gas_man_app/src/ui/warning_notice_screen.dart';

class DashboardPage extends StatelessWidget {
  final Color tealColor = const Color(0xFF007B7B);
  final Color amberColor = const Color(0xFFFFB300);
  final Color backgroundColor = const Color(0xFFF5F5F5);

  final List<Map<String, dynamic>> tools = [];

  DashboardPage({super.key}) {
    tools.addAll([
      {'icon': FontAwesomeIcons.fileCirclePlus, 'title': 'New Record', 'route': const RecordsScreen()},
      {'icon': FontAwesomeIcons.fileInvoice, 'title': 'Invoices', 'route': const InvoicesScreen()},
      {'icon': FontAwesomeIcons.briefcase, 'title': 'Jobs', 'route': const JobsPage()},
      {'icon': FontAwesomeIcons.user, 'title': 'Customers', 'route': const CustomerPage()},
      {'icon': FontAwesomeIcons.locationDot, 'title': 'Addresses', 'route': const AddressesScreen()},
      {'icon': FontAwesomeIcons.shop, 'title': 'Find Merchants', 'route': const FindMerchantsScreen()},
      {'icon': FontAwesomeIcons.piedPiper, 'title': 'Gas Pipe Sizing', 'route': const GasPipeSizingScreen()},
      {'icon': FontAwesomeIcons.wind, 'title': 'Ventilation', 'route': const VentilationScreen()},
      {'icon': FontAwesomeIcons.triangleExclamation, 'title': 'Warning Notices', 'route': const WarningNoticeScreen()},
      {'icon': FontAwesomeIcons.gaugeHigh, 'title': 'Gas Rate Calculator', 'route': const GasRateCalculatorScreen()},
      {'icon': FontAwesomeIcons.gear, 'title': 'Settings', 'route': const SettingsScreen()},
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Jobs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text("No jobs currently scheduled.",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Welcome to The Gas Man App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Grid of Tools
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tools.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = tools[index];
                final bool isAmber =
                    index == 1 || index == 9; // Highlight some boxes

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item['route']),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isAmber ? amberColor : tealColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], color: Colors.white, size: 36),
                        const SizedBox(height: 10),
                        Text(
                          item['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
