import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/text_style.dart';
import '../../api_model/online_order_details_model.dart';

class OnlineOrderDetailScreen extends StatefulWidget {
  OrderDetailsDto data;
  OnlineOrderDetailScreen({required this.data});

  @override
  State<OnlineOrderDetailScreen> createState() => _OnlineOrderDetailScreenState();
}

class _OnlineOrderDetailScreenState extends State<OnlineOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Order #${widget.data.id}',
          style: Text_Style.big(),
        ),
        Column(
          children: List.generate(
              widget.data.orderedProductDetailsDto?.length ?? 0,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.data.orderedProductDetailsDto?[index]
                                        .productMetadataUrls?[0] ??
                                    '',
                                height: 150,
                                width: (size.width - 32) * 0.4,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Arriving b gf gfgfdg fdg fd gfd g fdg dfOn :'),
                                  Text('Arriving On :'),
                                  Text('Arriving On :'),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/package.svg',
                              width: 25,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    ),
                  )),
        )
      ],
    );
  }
}
