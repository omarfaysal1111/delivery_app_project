import 'package:flutter/material.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/l10n/app_localizations.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Mock data for transactions
    final transactions = List.generate(
      10,
      (index) => _Transaction(
        orderNumber: '1535${3 - index}',
        date: '2026/10/${index + 1}',
        paymentMethod: index % 2 == 0
            ? 'فيزا'
            : 'كاش', // TODO: Localize if needed, for now mock
        total: '${(index + 1) * 150} ج.م',
      ),
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 4.0,
        title: Text(
          l10n.walletTitle,
          style: AppTextStyles.appBarTitle(context),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _BalanceCard(l10n: l10n, theme: theme),
                  const SizedBox(height: 20),
                  Text(
                    l10n.transactionHistory,
                    style: AppTextStyles.heading4(context).copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  _TransactionTable(
                    l10n: l10n,
                    theme: theme,
                    transactions: transactions,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.l10n, required this.theme});

  final AppLocalizations l10n;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 152,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF2C2B2B,
            ).withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1,350 ج.م", // Mock balance
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.currentBalance,
                    style: AppTextStyles.body(context).copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.paragraph(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 150,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary, // Maps to #A3090F natively
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        l10n.withdrawButton,
                        style: AppTextStyles.primaryButtonLabel.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/wallet@3x.png',
              width: 123,
              height: 123,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTable extends StatelessWidget {
  const _TransactionTable({
    required this.l10n,
    required this.theme,
    required this.transactions,
  });

  final AppLocalizations l10n;
  final ThemeData theme;
  final List<_Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF2C2B2B,
            ).withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1E1E1E)
                  : const Color(
                      0xFFF1F1F1,
                    ), // Respects Figma #F1F1F1 in light mode
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.border(context),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _HeaderCell(text: l10n.walletOrderNumber),
                ),
                Expanded(
                  flex: 3,
                  child: _HeaderCell(text: l10n.walletOrderDate),
                ),
                Expanded(
                  flex: 2,
                  child: _HeaderCell(text: l10n.walletPaymentMethod),
                ),
                Expanded(flex: 2, child: _HeaderCell(text: l10n.walletTotal)),
              ],
            ),
          ),
          // Data Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const SizedBox.shrink(),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index == transactions.length - 1
                          ? Colors.transparent
                          : AppColors.border(context),
                      width: 0.5,
                    ),
                  ),
                  borderRadius: index == transactions.length - 1
                      ? const BorderRadius.vertical(bottom: Radius.circular(16))
                      : BorderRadius.zero,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _DataCell(text: tx.orderNumber)),
                    Expanded(flex: 3, child: _DataCell(text: tx.date)),
                    Expanded(flex: 2, child: _DataCell(text: tx.paymentMethod)),
                    Expanded(flex: 2, child: _DataCell(text: tx.total)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppTextStyles.body(context).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500, // Medium
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  const _DataCell({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppTextStyles.body(context).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Book
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _Transaction {
  final String orderNumber;
  final String date;
  final String paymentMethod;
  final String total;

  _Transaction({
    required this.orderNumber,
    required this.date,
    required this.paymentMethod,
    required this.total,
  });
}
