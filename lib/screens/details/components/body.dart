import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/size_config.dart';
import '../similarProducts/similar_products.dart';
import 'buy_now_button.dart';
import 'components.dart';

class DetailFirebaseBody extends StatefulWidget {
  const DetailFirebaseBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<DetailFirebaseBody> createState() => _DetailFirebaseBodyState();
}

class _DetailFirebaseBodyState extends State<DetailFirebaseBody>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ListView(
          children: [
            Stack(
              children: [
                ProductImagesFirebase(product: widget.product),
                CustomAppBar(
                  rating: widget.product.rating,
                  color: Colors.transparent,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ProductDescription(
                          product: widget.product,
                          pressOnSeeMore: () {},
                        ),
                        RatingTile(
                          rating: widget.product.rating.toString(),
                        ),
                        ReviewsSheet(
                          product: widget.product,
                          image: widget.product.images.first,
                        ),
                        SimilarProducts(widget: widget),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(120)),
          ],
        ),
        BuyNowButton(
          product: widget.product,
          width: width,
          widget: widget,
        ),
      ],
    );
  }
}
