import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gif/gif.dart';

class OrderPlacedScreen extends StatefulWidget {
  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> with TickerProviderStateMixin {
  late GifController _controller;

  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: AppColors.primaryThemeColor,
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gif(
                image: AssetImage("assets/order_placed.gif"),
                controller:
                    _controller, // if duration and fps is null, original gif fps will be used.

                duration: const Duration(seconds: 3),
                autostart: Autostart.once,
                placeholder: (context) => const Text('Loading...'),
                onFetchCompleted: () {
                  _controller.reset();
                  _controller.forward();
                },
              ),
              // Image.asset('assets/order_placed.png'),
              SizedBox(
                height: 20,
              ),
              // SvgPicture.asset('assets/order_placed.svg'),
              Text(
                'Your Order has been placed',
                style: Text_Style.large(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
