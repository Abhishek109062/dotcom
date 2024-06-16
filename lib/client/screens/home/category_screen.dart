import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../components/color.dart';
import '../../../constants.dart';
import '../../view_model/home_view_model.dart';

class CategoryScreen extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     // Show a search dialog
          //     showSearch(context: context, delegate: LocationSearchDelegate());
          //   },
          // ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (_, viewModel, child) {
          return Container(
            // margin: EdgeInsets.all(4),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.8,
              children: List.generate(categories_list.length, (index) {
                return GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      viewModel.selectedCategory = index;
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFF5E1),
                        border: Border.all(
                          color: viewModel.selectedCategory == index
                              ? AppColors.primarySecondThemeColor
                              : Color(0xffFFF5E1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            categories_list[index]['image'],
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(categories_list[index]['name']),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

// class LocationSearchDelegate extends SearchDelegate<int> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, 0);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // Implement search results based on the query
//     final List<dynamic> searchResults = categories_list
//         .where((category) => category['name'].toLowerCase().contains(query))
//         .toList();
//
//     return ListView.builder(
//       itemCount: searchResults.length,
//       itemBuilder: (context, index) {
//         final location = searchResults[index];
//         return ListTile(
//           leading: SvgPicture.asset(
//             location['image'],
//             height: 40,
//             width: 40,
//           ),
//           title: Text(location['name']),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement search suggestions based on the query
//     final List<dynamic> searchResults = categories_list
//         .where((category) => category['name'].toLowerCase().contains(query))
//         .toList();
//
//     return ListView.builder(
//       itemCount: searchResults.length,
//       itemBuilder: (context, index) {
//         final location = searchResults[index];
//         return ListTile(
//           title: Text(location['name']),
//           onTap: () {
//             query = location['name'];
//             showResults(context);
//             // Navigator.pop(context);
//           },
//         );
//       },
//     );
//   }
// }
