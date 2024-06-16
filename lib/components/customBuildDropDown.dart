import 'package:flutter/material.dart';

Widget buildDropDown(BuildContext context, String label, List<String> options, String selectedValue,
    ValueChanged<String?> onChanged, double width,
    {bool isenabled = true}) {
  return Theme(
    data: Theme.of(context).copyWith(
      highlightColor: Color(0xff07C07C).withOpacity(0.08),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<String>(
            // position: PopupMenuPosition.under,
            enabled: isenabled,
            shadowColor: Colors.black45,
            constraints: BoxConstraints(maxHeight: 300),
            initialValue: selectedValue,
            itemBuilder: (BuildContext context) {
              return options.map((String value) {
                return PopupMenuItem<String>(
                  height: 40,
                  padding: EdgeInsets.zero,
                  value: value,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 4,
                                  color: selectedValue == value ? Colors.blue : Colors.white))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF211F1F).withOpacity(0.87),
                            ),
                          ),
                        ],
                      )),
                );
              }).toList();
            },
            // icon:,
            onSelected: onChanged,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),
              child: Row(
                children: [
                  Text(
                    label + ": ",
                    style: TextStyle(
                      color: Color(0xFF211F1F).withOpacity(0.64),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Text(
                      selectedValue,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF211F1F).withOpacity(0.87),
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ), // Add spacing between the label and selected value
        ],
      ),
    ),
  );
}

Widget buildDropDownFromMap(BuildContext context, String label, Map<String, String> options,
    String selectedValueKey, String selectedValue, ValueChanged<String?> onChanged, double width,
    {bool isenabled = true}) {
  return Theme(
    data: Theme.of(context).copyWith(
      highlightColor: Color(0xff07C07C).withOpacity(0.08),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<String>(
            enabled: isenabled,
            shadowColor: Colors.black45,
            constraints:
                BoxConstraints(maxHeight: 300, maxWidth: MediaQuery.of(context).size.width * .5),
            initialValue: selectedValueKey,
            itemBuilder: (BuildContext context) {
              List<PopupMenuItem<String>> popupMenuItems = [];
              options.forEach((String key, String value) {
                popupMenuItems.add(
                  PopupMenuItem<String>(
                    height: 40,
                    padding: EdgeInsets.zero,
                    value: key,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: selectedValueKey == key ? Colors.blue : Colors.white,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$value",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF211F1F).withOpacity(0.87),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
              return popupMenuItems;
            },
            // icon:,
            onSelected: onChanged,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),
              child: Row(
                children: [
                  Text(
                    label + ": ",
                    style: TextStyle(
                      color: Color(0xFF211F1F).withOpacity(0.64),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Text(
                      selectedValue,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF211F1F).withOpacity(0.87),
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ), // Add spacing between the label and selected value
        ],
      ),
    ),
  );
}
