import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_cart_animation/common/constants.dart';
import 'package:fruit_cart_animation/model/product.dart';
import 'package:fruit_cart_animation/presentation/bloc/product_bloc.dart';

class CustomProductCard extends StatefulWidget {
  final VoidCallback onIncrementPress;
  final Product product;

  final List<Product> cartItem;

  const CustomProductCard({
    super.key,
    required this.onIncrementPress,
    required this.cartItem,
    required this.product,
  });

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    animation = Tween(begin: 0, end: 1).animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {},
      child: InkWell(
        child: Container(
          padding: AppConstants.kProductContainerPadding,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  key: widget.product.key,
                  widget.product.image,
                  height: AppConstants.productImageHeight,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            widget.product.name,
                            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "₹ ${widget.product.price}/KG",
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 30,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                context
                                    .read<ProductBloc>()
                                    .add(OnDecrementEvent(cartItemList: widget.cartItem, product: widget.product));
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              )),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                            child: Text(
                              widget.product.itemInCart.toString(),
                              style: const TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          InkWell(
                              onTap: widget.onIncrementPress,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
