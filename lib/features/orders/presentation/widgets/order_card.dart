import 'package:flutter/material.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app_project/l10n/app_localizations.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isClosed =
        order.status == OrderStatus.delivered ||
        order.status == OrderStatus.cancelled;
    final bool isCancelled = order.status == OrderStatus.cancelled;

    // Status color logic mapped to theme
    Color getStatusColor() {
      switch (order.status) {
        case OrderStatus.waitingAcceptance:
          return AppColors.statusWarning;
        case OrderStatus.preparing:
        case OrderStatus.readyForPickup:
        case OrderStatus.courierOnWay:
          return AppColors.primary;
        case OrderStatus.delivered:
          return AppColors.statusClosed;
        case OrderStatus.cancelled:
          return Theme.of(context).colorScheme.error;
      }
    }

    String getStatusLabel() {
      switch (order.status) {
        case OrderStatus.waitingAcceptance:
          return l10n.orderStatusNew;
        case OrderStatus.preparing:
          return l10n.orderStatusPreparing;
        case OrderStatus.readyForPickup:
          return l10n.orderStatusReady;
        case OrderStatus.courierOnWay:
          return l10n.orderStatusOnWay;
        case OrderStatus.delivered:
          return l10n.orderStatusDelivered;
        case OrderStatus.cancelled:
          return l10n.orderStatusCancelled;
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigation to specific active order screens based on status could be done here
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.border(context), width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.store,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      order.restaurantName,
                      style: AppTextStyles.body(
                        context,
                      ).copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.orderFee(order.deliveryFee.toStringAsFixed(2)),
                      style: AppTextStyles.body(
                        context,
                      ).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.orderItemsCount(order.totalItems.toString()),
                      style: AppTextStyles.caption(
                        context,
                      ).copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: 17,
              thickness: 0.5,
              color: AppColors.border(context),
            ),
            Row(
              mainAxisAlignment: order.estimatedTime != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        isCancelled
                            ? Icons.cancel_outlined
                            : Icons.receipt_long,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getStatusLabel(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.caption(context).copyWith(
                            color: getStatusColor(),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.customerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.body(
                            context,
                          ).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                if (order.estimatedTime != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.orderEstTime,
                        style: AppTextStyles.caption(
                          context,
                        ).copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.estimatedTime!,
                        style: AppTextStyles.body(
                          context,
                        ).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
              ],
            ),
            if (!isClosed) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  for (var index = 0; index < 4; index++) ...[
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= order.status.index
                              ? Theme.of(context).colorScheme.primary
                              : AppColors.border(
                                  context,
                                ).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                    if (index != 3) const SizedBox(width: 4),
                  ],
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.border(
                      context,
                    ).withValues(alpha: isClosed ? 0.35 : 0.55),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isClosed ? l10n.orderClosed : l10n.orderActive,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(context).copyWith(
                      color: isClosed
                          ? AppColors.paragraph(context)
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // Navigate to details
                  },
                  child: Container(
                    width: 132,
                    height: 40, // refined height for UI balance
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      l10n.orderDetails,
                      style: AppTextStyles.primaryButtonLabel.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors
                            .white, // Ensure it contrasts with primary color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
