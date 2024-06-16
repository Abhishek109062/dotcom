// import 'package:flutter/material.dart';
//
//
//
// class FilterOptions extends StatefulWidget {
//   const FilterOptions({super.key});
//
//   @override
//   State<FilterOptions> createState() => _FilterOptionsState();
// }
//
// class _FilterOptionsState extends State<FilterOptions> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ,
//     )
//   }
// }
//
//
// class FilterMenuChallenger extends StatefulWidget {
//   String orderBy;
//   String filterBy;
//   Function(String, String) updateSort;
//   FilterMenuChallenger(
//       {required this.orderBy,
//         required this.updateSort,
//         required this.filterBy});
//
//   @override
//   _FilterMenuChallengerState createState() => _FilterMenuChallengerState();
// }
//
// class _FilterMenuChallengerState extends State<FilterMenuChallenger> {
//   List<String> orderOptions = ['Latest', 'Older'];
//   String selectedOrderBy = 'Latest';
//
//   List<String> filterOptions = ['All', 'Within Credit Range'];
//   String selectedFilter = "All";
//
//   String selectedOptions = "Order";
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       selectedOrderBy = widget.orderBy;
//       selectedFilter = widget.filterBy;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return DefaultTextStyle(
//         style: TextStyle(
//           fontFamily: "Poppins",
//           color: Colors.black,
//         ),
//         child: Container(
//           color: Colors.white,
//           height: size.height * 0.7,
//           width: double.maxFinite,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: size.height * 0.06,
//                   padding: EdgeInsets.all(size.height * 0.01),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Filter",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                       Spacer(),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Icon(
//                           Icons.close,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   height: 2,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 110,
//                       // padding: EdgeInsets.all(8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOptions = "Order";
//                               });
//                             },
//                             child: Container(
//                               width: 110,
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: selectedOptions == "Order"
//                                     ? AppColors.americanGreen.withOpacity(0.1)
//                                     : Colors.white,
//                                 border: Border(
//                                   left: BorderSide(
//                                     color: selectedOptions == "Order"
//                                         ? AppColors.americanGreen
//                                         : Colors.white, // Highlight color
//                                     width: 4.0, // Border width
//                                   ),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Order",
//                                 style: TextStyle(fontSize: 15),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOptions = 'Filter';
//                               });
//                             },
//                             child: Container(
//                               width: 110,
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: selectedOptions == "Filter"
//                                     ? AppColors.americanGreen.withOpacity(0.1)
//                                     : Colors.white,
//                                 border: Border(
//                                   left: BorderSide(
//                                     color: selectedOptions == "Filter"
//                                         ? AppColors.americanGreen
//                                         : Colors.white, // Highlight color
//                                     width: 4.0, // Border width
//                                   ),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Filter",
//                                 style: TextStyle(fontSize: 15),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: size.height * 0.56,
//                       width: 2,
//                       color: Colors.black.withOpacity(0.1),
//                     ),
//                     if (selectedOptions == 'Order')
//                       Expanded(
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: orderOptions.map((option) {
//                             return CheckboxListTile(
//                               title: Text(option),
//                               value: selectedOrderBy == option,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   if (value != null) {
//                                     if (value) {
//                                       selectedOrderBy = option;
//                                       print(selectedOrderBy);
//                                     }
//                                   }
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         ),
//                       )
//                     else if (selectedOptions == 'Filter')
//                       Expanded(
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: filterOptions.map((option) {
//                             return CheckboxListTile(
//                               title: Text(option),
//                               value: selectedFilter == option,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   if (value != null) {
//                                     if (value) {
//                                       selectedFilter = option;
//                                       print(selectedFilter);
//                                     }
//                                   }
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         ),
//                       )
//                   ],
//                 ),
//                 Divider(
//                   height: 2,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Container(
//                     margin: EdgeInsets.only(right: 8),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         primary: AppColors
//                             .americanGreen, // Set your desired color here
//                       ),
//                       onPressed: () {
//                         widget.updateSort(selectedOrderBy, selectedFilter);
//                         Navigator.pop(context);
//                       },
//                       child: Text('Apply',
//                           style: TextStyle(
//                             fontSize: 15,
//                           ),
//                           textAlign: TextAlign.center),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
