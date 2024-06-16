import 'package:dot_com/client/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/color.dart';
import '../../components/text_style.dart';
import '../../constants.dart';
import '../view_model/home_view_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Consumer<HomeViewModel>(builder: (_, viewModel, child) {
        return Container(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 / 0.8,
            children: List.generate(location_list.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                },
                child: GestureDetector(
                  onTap: () {
                    viewModel.selectedLocation = index;
                    Navigator.pop(context);
                    // viewModel.selectedCategory(categories_list[index]['']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFFF5E1),
                      border: Border.all(
                        color: viewModel.selectedLocation == index
                            ? AppColors.primarySecondThemeColor
                            : Color(0xffFFF5E1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(right: 12, top: 12),
                    padding: EdgeInsets.all(8),
                    // color: Colors.red,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          location_list[index]['image'],
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(location_list[index]['name'])
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
