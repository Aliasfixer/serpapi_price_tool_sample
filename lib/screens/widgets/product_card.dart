import 'package:flutter/material.dart';
import 'package:serpapi_price_tool_sample/constants/app_colors.dart';
import 'package:serpapi_price_tool_sample/constants/app_typography.dart';
import 'package:serpapi_price_tool_sample/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constrains) {
        return Container(
          height: constrains.maxHeight,
          width: constrains.maxHeight * 0.8,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black45,
              width: 0.5
            )
          ),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Image.network(
                    product.thumbnail!,
                  ),
                ),
              ),

              const SizedBox(height: 5,),

              Text(
                product.source,
                style: AppTypography.small(
                  context,
                  color: AppColors.primary
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 5,),

              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppTypography.medium(
                  context,
                  color: AppColors.primary
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
      }
    );
  }
}