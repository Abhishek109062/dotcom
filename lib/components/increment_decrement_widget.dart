import 'package:dot_com/components/color.dart';
import 'package:flutter/material.dart';

class IncrementDecrementWidget extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int>? onChanged; // Callback function

  IncrementDecrementWidget({
    Key? key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    this.onChanged, // Callback function
  }) : super(key: key);

  @override
  _IncrementDecrementWidgetState createState() => _IncrementDecrementWidgetState();
}

class _IncrementDecrementWidgetState extends State<IncrementDecrementWidget> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _increment() {
    setState(() {
      if (_value < widget.maxValue) {
        _value++;
        widget.onChanged?.call(_value); // Call onChanged callback
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_value > widget.minValue) {
        _value--;
        widget.onChanged?.call(_value); // Call onChanged callback
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: _increment,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Icon(
                Icons.add,
                size: 12,
              ),
            ),
          ),
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   icon: Icon(
          //     Icons.add,
          //     size: 12,
          //   ),
          //   onPressed: _increment,
          // ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.primarySecondThemeColor,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Text(
              '$_value',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: _decrement,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Icon(
                Icons.remove,
                size: 12,
              ),
            ),
          ),
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   icon: Icon(
          //     Icons.remove,
          //     size: 12,
          //   ),
          //   onPressed: _decrement,
          // ),
        ],
      ),
    );
  }
}
