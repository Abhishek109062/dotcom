import 'package:dot_com/admin/layouts/admin_search_overlay.dart';
import 'package:dot_com/admin/subadmin/data/model/subadmin_model.dart';
import 'package:dot_com/admin/subadmin/presentation/pages/add_subadmin_page.dart';
import 'package:dot_com/admin/subadmin/presentation/pages/update_subadmin_page.dart';
import 'package:dot_com/admin/subadmin/repository/subadmin_repository.dart';
import 'package:dot_com/admin/subadmin/viewModel/subadmin_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../components/customsnackbar.dart';
import '../../../../components/text_style.dart';

class SubAdminPage extends StatefulWidget {
  static Route<bool> route() =>
      MaterialPageRoute<bool>(
          builder: (_) =>
              ChangeNotifierProvider(
                create: (BuildContext context) => SubAdminViewModel(),
                child: SubAdminPage(),
              ));

  @override
  State<SubAdminPage> createState() => _SubAdminPageState();
}

class _SubAdminPageState extends State<SubAdminPage> {
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode searchFocus = FocusNode();
  String search = "";
  int tag = 3;

  // list of string options
  List<String> options = [];

  onSearchChanged(String val) {
    setState(() {
      this.search = val;
    });
  }

  String _selectedOption = '';


  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SubAdminViewModel>(context, listen: false).getAllSubAdmins();
      _scrollController.addListener(() =>
          Provider.of<SubAdminViewModel>(context, listen: false)
              .scrollListener(_scrollController));
    });
    super.initState();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Color(0xfffff9ec),
      context: context,
      builder: (BuildContext context) {
        return FilterMenuSubAdmin(
          onApply: (String? value) {
            setState(() {
              _selectedOption = value ?? "";
              addOption(_selectedOption);
            });
          },
          selectedValue: _selectedOption,
        );
      },
    );
  }

  addOption(String status) {
    switch (status) {
      case "Block":
        options = ["Blocked"];
        break;
      case "unBlock":
        options = ["Unblocked"];
      default:
        options = [];
    }
  }

  clearFilter() {
    setState(() {
      _selectedOption = "";
      addOption(_selectedOption);
    });
  }

  resetPage() {}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFDFA),
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFEE4540),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "dot.",
                  style: Text_Style.small(
                      color: Color(0xFFEE4540), fontWeight: FontWeight.w700),
                ),
                Text(
                  "ComSale",
                  style: Text_Style.small(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Admin123",
                  style: Text_Style.large(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFEE4540), width: 1)),
                    child: Icon(
                      Icons.person,
                      color: Color(0xFFEE4540),
                    ))
              ],
            )
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Consumer<SubAdminViewModel>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sub-admin List",
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFf4f6f9),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    visualDensity: VisualDensity(horizontal: 2, vertical: -4),
                    minVerticalPadding: 0,
                    trailing: GestureDetector(
                        onTap: () {
                          searchController.clear();
                        },
                        child: Icon(Icons.search)),
                    contentPadding: EdgeInsets.zero,
                    title: Container(
                      child: TextFormField(
                        controller: searchController,
                        focusNode: searchFocus,
                        onTapOutside: (tap) {
                          searchFocus.unfocus();
                        },
                        onChanged: (val) {
                          setState(() {
                            search = val ?? "";
                            onSearchChanged(search);
                          });
                        },
                        onFieldSubmitted: (String val) {},
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: "Search",
                            border: InputBorder.none,
                            isDense: true
                          // errorText: false ? 'Last Name is required' : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 8,
                            child: options.isNotEmpty
                                ? ChipsChoice<int>.single(
                              value: tag,
                              onChanged: (val) => setState(() => tag = val),
                              choiceItems: C2Choice.listFrom<int, String>(
                                source: options,
                                value: (i, v) => i,
                                label: (i, v) => v,
                                tooltip: (i, v) => v,
                                delete: (i, v) =>
                                    () {
                                  clearFilter();
                                },
                              ),
                              choiceStyle: C2ChipStyle.toned(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  backgroundColor: Color(0xffDC143C),
                                  backgroundOpacity: 1),
                              // leading: IconButton(
                              //   tooltip: 'Add Choice',
                              //   icon: const Icon(Icons.add_box_rounded),
                              //   onPressed: () => setState(
                              //         () => options.add('Opt #${options.length + 1}'),
                              //   ),
                              // ),
                              // trailing: IconButton(
                              //   tooltip: 'Remove Choice',
                              //   icon: const Icon(Icons.remove_circle),
                              //   onPressed: () => setState(() => options.removeLast()),
                              // ),
                              wrapped: false,
                            )
                                : Container(),
                          ),
                          Flexible(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  _showBottomSheet();
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/filtericon.svg"),
                                      Text(
                                        "Filters",
                                        style: Text_Style.medium(),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                      // ListView.builder(shrinkWrap: true,itemCount: 10,itemBuilder: (context,index){
                      //   return adminListTile();
                      // }),
                    ],
                  ),
                ),
                Expanded(
                  child: provider.isLoading
                      ? Center(
                    child: Container(height: 24, width: 24, child: CircularProgressIndicator(),),)
                      : Scrollbar(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ...List.generate(provider.subAdmins.length, (index) {
                              return adminListTile(provider.subAdmins[index]);
                            }),
                            if (provider.isLoadingMore && provider.isNoMore == false)
                              Container(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xffFC5D5D),
                                      )),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            );
          },
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(0)),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        child: Row(
          children: [
            Expanded(
                child: TextButton(
                    onPressed: () async {
                      bool res = await Navigator.of(context)
                          .push(AddSubadmin.route()) ??
                          false;

                      if (true) {
                        successSnackBar(
                            msg: "SubAdmin Registered Successfully");
                      }
                    },
                    style: TextButton.styleFrom(
                        maximumSize: Size.fromHeight(44),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Color(0xffFC5D5D)),
                    child: Text(
                      "Add SubAdmin",
                      style: Text_Style.medium(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }

  Widget adminListTile(SubAdminDto subAdmin) {
    return Consumer<SubAdminViewModel>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(UpdateSubadmin.route(id: subAdmin.id));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xFFEE4540), width: 1)),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFFEE4540),
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Flexible(
                          flex: 8,
                          child: Text(
                            "${subAdmin.name}",
                            style: Text_Style.medium(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: TextButton(
                      child: provider.blocking.containsKey(subAdmin.id)
                          ? SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                          : Text(
                        "Block",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (provider.blocking.containsKey(subAdmin.id) == false)
                          provider.blockUser(subAdmin.id);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: provider.blocking.containsKey(subAdmin.id)
                            ? Color(0xffFA7153).withOpacity(.5)
                            : Color(0xffFA7153),
                        minimumSize: Size.fromHeight(30),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class FilterMenuSubAdmin extends StatefulWidget {
  final Function(String?) onApply;
  final String selectedValue;

  const FilterMenuSubAdmin({super.key, required this.onApply, required this.selectedValue});

  @override
  State<FilterMenuSubAdmin> createState() => _FilterMenuSubAdminState();
}

class _FilterMenuSubAdminState extends State<FilterMenuSubAdmin> {
  late String selectedValue;

  @override
  void initState() {
    this.selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Filter",
              style: TextStyle(
                  color: Color(0xfffc5d5d),
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          RadioListTile(
            title: Text('Blocked'),
            value: 'Block',
            activeColor: Color(0xfffc5d5d),
            groupValue: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value ?? "";
              });
            },
          ),
          RadioListTile(
            title: Text('Unblocked'),
            value: 'unBlock',
            activeColor: Color(0xfffc5d5d),
            groupValue: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value ?? "";
              });
            },
          ),
          RadioListTile(
            title: Text('All'),
            value: '',
            activeColor: Color(0xfffc5d5d),
            groupValue: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value ?? "";
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                        child: Text(
                          'Cancel',
                          style: Text_Style.medium(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        )),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      widget.onApply(selectedValue);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xfffc5d5d),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Center(
                        child: Text(
                          'Apply',
                          style: Text_Style.medium(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
