import 'package:flutter/material.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/features/orders/domain/entities/order_entity.dart';

/// Order Details Screen — Figma node-id: 7811-9813
/// Layout: Real map image (40%) → overlapping white details card (60%+).
/// Entire layout is RTL. All content is right-aligned (start = right).
class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // ── Real map image — 40% of screen ────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.40,
              child: Image.asset(
                'assets/images/map_placeholder.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: const Color(0xFFD6E4F0),
                  child: Center(
                    child: Icon(
                      Icons.map_outlined,
                      size: 70,
                      color: Colors.blueGrey.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
            ),

            // ── Transparent back button overlaid on map ────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.88),
                      shape: const CircleBorder(),
                      elevation: 2,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(9),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Details card overlapping the map ──────────────────────────
            Positioned(
              top: screenHeight * 0.34,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 20,
                      offset: Offset(0, -6),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Order Header ─────────────────────────────────────
                      _OrderHeader(order: order),
                      _Divider(),

                      // ── Restaurant Info ───────────────────────────────────
                      _RestaurantSection(order: order),
                      _Divider(),

                      // ── Customer Info ─────────────────────────────────────
                      _CustomerSection(order: order),
                      _Divider(),

                      // ── Delivery Route ────────────────────────────────────
                      _DeliveryRouteSection(order: order),
                      _Divider(),

                      // ── Customer Rating ───────────────────────────────────
                      _RatingSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ORDER HEADER
// ─────────────────────────────────────────────────────────────────────────────
class _OrderHeader extends StatelessWidget {
  final OrderEntity order;
  const _OrderHeader({required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Right (start): Order ID
        Text(
          '#${order.id} :طلب رقم',
          style: AppTextStyles.body(context).copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        // Left (end): items • price
        Text(
          '${order.totalItems} منتجات • ${order.deliveryFee.toStringAsFixed(0)} ج.م',
          style: AppTextStyles.caption(context).copyWith(
            fontSize: 12,
            color: AppColors.paragraph(context),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RESTAURANT SECTION — all content starts from the right
// ─────────────────────────────────────────────────────────────────────────────
class _RestaurantSection extends StatelessWidget {
  final OrderEntity order;
  const _RestaurantSection({required this.order});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant logo + name + phone + call icon — all start-aligned
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/restaurant/az_al_sham_logo.png',
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.store_rounded, color: primary, size: 22),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Name + phone + icon grouped together
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.restaurantName,
                  style: AppTextStyles.body(context).copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      order.customerPhone,
                      style: AppTextStyles.caption(context).copyWith(
                        fontSize: 12,
                        color: AppColors.paragraph(context),
                      ),
                    ),
                    const SizedBox(width: 6),
                    _RedCallIcon(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CUSTOMER SECTION — all content starts from the right
// ─────────────────────────────────────────────────────────────────────────────
class _CustomerSection extends StatelessWidget {
  final OrderEntity order;
  const _CustomerSection({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'بيانات العميل :',
          style: AppTextStyles.body(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        // Name + phone + call icon — all start-aligned, no spaceBetween
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.customerName,
              style: AppTextStyles.body(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  order.customerPhone,
                  style: AppTextStyles.caption(context).copyWith(
                    fontSize: 12,
                    color: AppColors.paragraph(context),
                  ),
                ),
                const SizedBox(width: 6),
                _RedCallIcon(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DELIVERY ROUTE — vertical dotted timeline, all start-aligned
// ─────────────────────────────────────────────────────────────────────────────
class _DeliveryRouteSection extends StatelessWidget {
  final OrderEntity order;
  const _DeliveryRouteSection({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نطاق التوصيل :',
          style: AppTextStyles.body(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        // Timeline row: icons | text — all on the right (start)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Vertical icon column with dotted connector
            Column(
              children: [
                const Icon(Icons.location_on, color: Colors.black87, size: 22),
                SizedBox(
                  height: 36,
                  width: 2,
                  child: CustomPaint(painter: _DottedLinePainter()),
                ),
                Icon(Icons.location_on, color: AppColors.primary, size: 22),
              ],
            ),
            const SizedBox(width: 10),
            // Addresses column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'من :',
                  style: AppTextStyles.caption(context).copyWith(
                    fontSize: 11,
                    color: AppColors.paragraph(context),
                  ),
                ),
                Text(
                  order.pickupAddress,
                  style: AppTextStyles.body(context).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'الى :',
                  style: AppTextStyles.caption(context).copyWith(
                    fontSize: 11,
                    color: AppColors.paragraph(context),
                  ),
                ),
                Text(
                  order.deliveryAddress,
                  style: AppTextStyles.body(context).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RATING SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _RatingSection extends StatelessWidget {
  const _RatingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تقييم العميل :',
          style: AppTextStyles.body(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (_) => const Icon(
              Icons.star_rounded,
              color: Color(0xFFFFC107),
              size: 22,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'المندوب كان في غاية من الاحترام والتعامل الراقي مع العميل.',
          style: AppTextStyles.body(context).copyWith(
            fontSize: 12,
            color: AppColors.paragraph(context),
            height: 1.7,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED HELPERS
// ─────────────────────────────────────────────────────────────────────────────

/// Red circular call icon button.
class _RedCallIcon extends StatelessWidget {
  const _RedCallIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.phone_rounded,
        color: AppColors.primary,
        size: 14,
      ),
    );
  }
}

/// Subtle section divider.
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(height: 1, thickness: 0.5, color: Color(0xFFEEEEEE)),
    );
  }
}

/// Custom painter for a dotted vertical line.
class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dash = 4.0;
    const gap = 3.0;
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dash), paint);
      y += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
