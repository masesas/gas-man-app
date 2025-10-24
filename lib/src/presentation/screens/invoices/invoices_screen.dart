import 'package:flutter/material.dart';
import 'package:gas_man_app/src/theme/app_colors.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final List<Invoice> _invoices = [
    Invoice(
      id: 'INV-001',
      customerName: 'John Smith',
      amount: 250.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: InvoiceStatus.paid,
    ),
    Invoice(
      id: 'INV-002',
      customerName: 'Sarah Johnson',
      amount: 450.00,
      date: DateTime.now().subtract(const Duration(days: 10)),
      status: InvoiceStatus.pending,
    ),
    Invoice(
      id: 'INV-003',
      customerName: 'Mike Wilson',
      amount: 325.00,
      date: DateTime.now().subtract(const Duration(days: 15)),
      status: InvoiceStatus.overdue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Invoices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: _createNewInvoice,
                icon: const Icon(Icons.add),
                label: const Text('New Invoice'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._invoices.map((invoice) => _buildInvoiceCard(invoice)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewInvoice,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Total Outstanding',
            value: '£775.00',
            color: Colors.orange,
            icon: Icons.pending_actions,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: 'This Month',
            value: '£1,025.00',
            color: Colors.green,
            icon: Icons.calendar_today,
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceCard(Invoice invoice) {
    Color statusColor;
    IconData statusIcon;
    
    switch (invoice.status) {
      case InvoiceStatus.paid:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case InvoiceStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case InvoiceStatus.overdue:
        statusColor = Colors.red;
        statusIcon = Icons.error_outline;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(
          invoice.customerName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${invoice.id} • ${_formatDate(invoice.date)}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '£${invoice.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              invoice.status.name.toUpperCase(),
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        onTap: () => _viewInvoiceDetails(invoice),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _createNewInvoice() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening new invoice form...')),
    );
  }

  void _viewInvoiceDetails(Invoice invoice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing invoice ${invoice.id}...')),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum InvoiceStatus { paid, pending, overdue }

class Invoice {
  final String id;
  final String customerName;
  final double amount;
  final DateTime date;
  final InvoiceStatus status;

  Invoice({
    required this.id,
    required this.customerName,
    required this.amount,
    required this.date,
    required this.status,
  });
}
