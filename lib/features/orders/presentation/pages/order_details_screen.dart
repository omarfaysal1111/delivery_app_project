import 'package:flutter/material.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/features/orders/domain/entities/order_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Order Details Screen — Figma node-id: 7811-9813
/// Layout: Real map image (40%) → overlapping white details card (60%+).
/// Entire layout is RTL. All content is right-aligned (start = right).
class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 16, // Screen side padding
          title: Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Transform.flip(
                  flipX: Directionality.of(context) == TextDirection.ltr,
                  child: Image.asset(
                    'assets/images/orders/back.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              const SizedBox(width: 4), // Exactly 4px gap
              const Text(
                'تفاصيل الطلب',
                style: TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'ExpoArabic',
                ),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            return Stack(
              children: [
                // ── Real map image — 40% to 45% of available height ─────────
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: availableHeight * 0.45,
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

                // ── Details card overlapping the map ──────────────────────────
                Positioned(
                  top: availableHeight * 0.40,
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
                          const _Divider(),

                          // ── Restaurant Info ───────────────────────────────────
                          _RestaurantSection(order: order),
                          const _Divider(),

                          // ── Customer Info ─────────────────────────────────────
                          _CustomerSection(order: order),
                          const _Divider(),

                          // ── Delivery Route ────────────────────────────────────
                          _DeliveryRouteSection(order: order),
                          const _Divider(),

                          // ── Customer Rating ───────────────────────────────────
                          const _RatingSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
        // Right (start): Order ID fixing RTL Bidirectional rendering
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'طلب رقم : ',
              style: AppTextStyles.body(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF787878),
              ),
            ),
            Text(
              '#${order.id}',
              textDirection: TextDirection.ltr,
              style: AppTextStyles.body(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1B1B1B),
              ),
            ),
          ],
        ),
        const Spacer(),
        // Left (end): items • price
        RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${order.totalItems} منتجات ',
                style: AppTextStyles.caption(context).copyWith(
                  fontSize: 12,
                  color: const Color(0xFF787878),
                ),
              ),
              TextSpan(
                text: '• ',
                style: AppTextStyles.caption(context).copyWith(
                  fontSize: 12,
                  color: const Color(0xFFA3090F),
                ),
              ),
              TextSpan(
                text: '${order.deliveryFee.toStringAsFixed(0)} ج.م',
                style: AppTextStyles.caption(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1B1B1B),
                ),
              ),
            ],
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
                'assets/images/orders/az_al_sham_logo.png',
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
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1B1B1B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _RedCallIcon(),
                    const SizedBox(width: 8),
                    Text(
                      order.customerPhone,
                      textDirection: TextDirection.ltr,
                      style: AppTextStyles.caption(context).copyWith(
                        fontSize: 12,
                        color: AppColors.paragraph(context),
                      ),
                    ),
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1B1B1B),
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
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1B1B1B),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _RedSmartphoneIcon(),
                const SizedBox(width: 8),
                Text(
                  order.customerPhone,
                  textDirection: TextDirection.ltr,
                  style: AppTextStyles.caption(context).copyWith(
                    fontSize: 12,
                    color: AppColors.paragraph(context),
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1B1B1B),
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
                SvgPicture.asset(
                  'assets/icons/orders/pin_location.svg',
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                ),
                SizedBox(
                  height: 36,
                  width: 2,
                  child: CustomPaint(painter: _DottedLinePainter()),
                ),
                SvgPicture.asset(
                  'assets/icons/orders/pin_location.svg',
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1B1B1B),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) {
              if (index == 4) {
                return Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Image.asset(
                    'assets/images/orders/star_half.png',
                    width: 22,
                    height: 22,
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Image.asset(
                  'assets/images/orders/star_full.png',
                  width: 22,
                  height: 22,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'المندوب كان في غاية من الاحترام ، والسرعة',
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
    return SvgPicture.asset(
      'assets/icons/orders/calling.svg',
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    );
  }
}

/// Red circular smartphone icon button.
class _RedSmartphoneIcon extends StatelessWidget {
  const _RedSmartphoneIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/orders/smart_phone.svg',
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
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
