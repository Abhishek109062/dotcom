import 'package:dot_com/components/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../view_model/home_view_model.dart';

class FilterScreen extends StatefulWidget {
  VoidCallback onClose;
  FilterScreen({required this.onClose});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<dynamic> selectedFilters = [];
  String selectedSortBy = '';

  List<String> sortByOptions = ['A to Z', 'Z to A', 'Newest First', 'Oldest First'];

  String selectedOptions = "Gender";

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryThemeColor,
      body: DefaultTextStyle(
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
          ),
          child: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            viewModel.clearAllFilters();
                          },
                          child: Text(
                            "Clear All",
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOptions = "Gender";
                                });
                              },
                              child: Container(
                                width: 110,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: selectedOptions == "Gender"
                                        ? AppColors.primarySecondThemeColor.withOpacity(0.2)
                                        : AppColors.primaryThemeColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontSize: 15, color: AppColors.primarySecondThemeColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOptions = 'Categories';
                                });
                              },
                              child: Container(
                                width: 110,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: selectedOptions == "Categories"
                                        ? AppColors.primarySecondThemeColor.withOpacity(0.2)
                                        : AppColors.primaryThemeColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 15, color: AppColors.primarySecondThemeColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOptions = 'Sizes';
                                });
                              },
                              child: Container(
                                width: 110,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: selectedOptions == "Sizes"
                                        ? AppColors.primarySecondThemeColor.withOpacity(0.2)
                                        : AppColors.primaryThemeColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Sizes",
                                  style: TextStyle(
                                      fontSize: 15, color: AppColors.primarySecondThemeColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOptions = 'Color';
                                });
                              },
                              child: Container(
                                width: 110,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: selectedOptions == "Color"
                                        ? AppColors.primarySecondThemeColor.withOpacity(0.2)
                                        : AppColors.primaryThemeColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Color",
                                  style: TextStyle(
                                      fontSize: 15, color: AppColors.primarySecondThemeColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.56,
                        width: 2,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      if (selectedOptions == 'Gender')
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: size.height * 0.5 - 52,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: (filters['gender'] ?? []).map((option) {
                                return CheckboxListTile(
                                  title: Text(
                                    option,
                                    style: TextStyle(color: AppColors.primarySecondThemeColor),
                                  ),
                                  value: viewModel.gender == option,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          // Checkbox is being selected
                                          viewModel.gender = option;
                                          print(selectedSortBy);
                                          // Implement sorting logic here
                                        } else {
                                          // Checkbox is being unselected
                                          viewModel.gender = ''; // or selectedSortBy = '';
                                          print(selectedSortBy);
                                          // Implement logic for deselection here if needed
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      else if (selectedOptions == 'Sizes')
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: size.height * 0.5 - 52,
                            ),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: (filters['sizes'] ?? []).map((option) {
                                return CheckboxListTile(
                                  title: Text(
                                    option,
                                    style: TextStyle(color: AppColors.primarySecondThemeColor),
                                  ),
                                  value: viewModel.sizes == option,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          viewModel.sizes = option;
                                        } else {
                                          viewModel.sizes = ''; // or selectedSortBy = '';
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      else if (selectedOptions == 'Categories')
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: size.height * 0.5 - 52,
                            ),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: (filters['filters'] ?? []).map((option) {
                                return CheckboxListTile(
                                  title: Text(
                                    option,
                                    style: TextStyle(color: AppColors.primarySecondThemeColor),
                                  ),
                                  value: viewModel.filters == option,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          // Checkbox is being selected
                                          viewModel.filters = option;
                                          print(selectedSortBy);
                                          // Implement sorting logic here
                                        } else {
                                          // Checkbox is being unselected
                                          viewModel.filters = ''; // or selectedSortBy = '';
                                          print(selectedSortBy);
                                          // Implement logic for deselection here if needed
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      else if (selectedOptions == 'Color')
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: size.height * 0.5 - 52,
                            ),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: (filters['color'] ?? []).map((option) {
                                return CheckboxListTile(
                                  title: Text(
                                    option,
                                    style: TextStyle(color: AppColors.primarySecondThemeColor),
                                  ),
                                  value: viewModel.color == option,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          viewModel.color = option;
                                          print(selectedSortBy);
                                        } else {
                                          viewModel.color = ''; // or selectedSortBy = '';
                                          print(selectedSortBy);
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          })),
      bottomSheet: Container(
        height: 40,
        color: AppColors.primaryThemeColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: AppColors.primaryThemeColor,
                  surfaceTintColor: AppColors.primaryThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Set border radius to zero
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  widget.onClose();
                },
                child: Text('Cancel',
                    style: TextStyle(fontSize: 15, color: AppColors.primarySecondThemeColor),
                    textAlign: TextAlign.center),
              ),
            ),
            Consumer<HomeViewModel>(builder: (context, viewModel, child) {
              return Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: AppColors.primarySecondThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Set border radius to zero
                  ), // Set your desired color here
                ),
                onPressed: () {
                  viewModel.initialPage();
                  Navigator.pop(context);
                  widget.onClose();
                  // widget.updateSort(selectedFilters, selectedSortBy);
                  // context.pop();
                  // Navigator.pop(context);
                },
                child: Text('Apply',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center),
              ));
            }),
          ],
        ),
      ),
    );
  }

  Widget filteroptions(String data) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: (filters['data'] ?? []).map((option) {
          return CheckboxListTile(
            title: Text(option),
            value: selectedSortBy == option,
            onChanged: (bool? value) {
              setState(() {
                if (value != null) {
                  if (value) {
                    // Checkbox is being selected
                    selectedSortBy = option;
                    print(selectedSortBy);
                    // Implement sorting logic here
                  } else {
                    // Checkbox is being unselected
                    selectedSortBy = ''; // or selectedSortBy = '';
                    print(selectedSortBy);
                    // Implement logic for deselection here if needed
                  }
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
