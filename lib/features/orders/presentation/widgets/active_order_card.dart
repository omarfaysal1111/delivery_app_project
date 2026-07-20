import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/active_order_cubit.dart';
import '../bloc/active_order_state.dart';
import 'dashed_line_painter.dart';

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveOrderCubit, ActiveOrderState>(
      builder: (context, state) {
        if (state is ActiveOrderIdle) {
          return const SizedBox.shrink();
        }

        final l10n = AppLocalizations.of(context)!;
        final isAssigned = state is ActiveOrderAssigned;
        final isPickedUp = state is ActiveOrderPickedUp;
        final isDelivered = state is ActiveOrderDelivered;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header (Price, Items, Order ID)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '340 ج.م', // Mock price
                          style: AppTextStyles.inputText(
                            context,
                          ).copyWith(color: AppColors.onSurface(context)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.trackingItems('3'),
                          style: AppTextStyles.caption(
                            context,
                          ).copyWith(color: AppColors.onSurface(context)),
                        ),
                      ],
                    ),
                    Text(
                      l10n.trackingOrderNo('10332'),
                      style: AppTextStyles.inputText(
                        context,
                      ).copyWith(color: AppColors.onSurface(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1,
                ),
                const SizedBox(height: 12),

                // Route Timeline
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Timeline Graphic
                      Column(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: CustomPaint(
                                size: const Size(1, double.infinity),
                                painter: DashedLinePainter(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),

                      // Route Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.trackingFrom(
                                'القاهره الجديده ، مدينتي ، حي الزهور',
                              ),
                              style: AppTextStyles.body(
                                context,
                              ).copyWith(color: AppColors.onSurface(context)),
                            ),
                            Text(
                              l10n.trackingExpectedDistanceShort('2.5'),
                              style: AppTextStyles.caption(
                                context,
                              ).copyWith(color: AppColors.paragraph(context)),
                            ),
                            const Spacer(),
                            const SizedBox(height: 12),
                            Text(
                              l10n.trackingTo(
                                'القاهره الجديده ، مدينتي ، حي النور',
                              ),
                              style: AppTextStyles.body(
                                context,
                              ).copyWith(color: AppColors.onSurface(context)),
                            ),
                            Text(
                              l10n.trackingExpectedDistanceShort('5'),
                              style: AppTextStyles.caption(
                                context,
                              ).copyWith(color: AppColors.paragraph(context)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1,
                ),
                const SizedBox(height: 12),

                // Customer Details (Only shows if NOT Assigned)
                if (!isAssigned) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.trackingCustomerDetails,
                        style: AppTextStyles.heading4(
                          context,
                        ).copyWith(color: AppColors.onSurface(context)),
                      ),
                      Row(
                        children: [
                          Text(
                            'احمد فرج', // Mock customer name
                            style: AppTextStyles.inputText(
                              context,
                            ).copyWith(color: AppColors.onSurface(context)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '01004059966', // Mock customer phone
                            style: AppTextStyles.body(
                              context,
                            ).copyWith(color: AppColors.onSurface(context)),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.phone_outlined,
                            color: AppColors.primary,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                ],

                // Footer / Action Button
                if (isAssigned) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        l10n.trackingExpectedTotalDistance('7.5'),
                        style: AppTextStyles.buttonHeading(
                          context,
                        ).copyWith(color: AppColors.onSurface(context)),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_outward,
                        color: AppColors.onSurface(context),
                        size: 20,
                      ),
                    ],
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      if (isPickedUp) {
                        context.read<ActiveOrderCubit>().confirmDelivery();
                      } else if (isDelivered) {
                        context.read<ActiveOrderCubit>().finishOrder();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      isPickedUp
                          ? l10n.trackingConfirmPickup
                          : l10n.trackingConfirmDelivery,
                      style: AppTextStyles.buttonHeading(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
