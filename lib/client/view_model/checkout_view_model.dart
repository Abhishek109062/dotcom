import 'dart:convert';

import 'package:dot_com/utils/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../constants.dart';
import '../api_model/add_order_details_request_model.dart';
import '../api_model/add_order_details_response_model.dart';
import '../api_model/verify_orderPrice_response_model.dart';
import '../repository/client_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class CheckOutViewModel with ChangeNotifier {
  final _client_rep = ClientRepository();
  VerifyOrderPriceResponseModel? _checkOutData = null;
  AddOrderDetailsResponseModel? _addOrderData = null;
  BuildContext? _context;
  String _selectedPaymentMethod = 'Online';
  double _TotalAmount = 0;
  double _TotalDiscount = 0;
  double _shippingCharges = 0;
  double _grandTotal = 0;

  String get selectedPaymentMethod => _selectedPaymentMethod;

  set selectedPaymentMethod(String value) {
    _selectedPaymentMethod = value;
    notifyListeners();
  }

  double get grandTotal => _grandTotal;

  double get shippingCharges => _shippingCharges;

  double get TotalAmount => _TotalAmount;

  set grandTotal(double value) {
    _grandTotal = value;
  }

  double get TotalDiscount => _TotalDiscount;
  set TotalDiscount(double value) {
    _TotalDiscount = value;
  }

  set shippingCharges(double value) {
    _shippingCharges = value;
    updateTotalAndDiscount();
  }

  set TotalAmount(double value) {
    _TotalAmount = value;
  }

  updateTotalAndDiscount() {
    TotalAmount = 0;
    TotalDiscount = 0;
    // checkOutData!.paymentMode = 'TakeAway';

    for (VerifiedProductsList copy in (_checkOutData?.verifiedProductsList ?? [])) {
      TotalAmount = (TotalAmount +
          (copy.productTotalPriceWithoutDiscount ?? 0) * (copy.productQuantity ?? 0));
      TotalDiscount = TotalDiscount +
          ((copy.productTotalPriceWithoutDiscount ?? 0) *
              (copy.productQuantity ?? 0) *
              (copy.productDiscount ?? 0) /
              100);
    }

    grandTotal = TotalAmount - TotalDiscount + shippingCharges;
    notifyListeners();
  }

  VerifyOrderPriceResponseModel? get checkOutData => _checkOutData ?? null;

  Future<bool> verifyOrderPrice(Map<String, dynamic> data) async {
    try {
      dynamic temp = await _client_rep.callVerifyOrderPriceApi(data);
      _checkOutData = VerifyOrderPriceResponseModel.fromJson(jsonDecode(temp.body));
      _shippingCharges = (checkOutData?.shippingCharges ?? 0).toDouble();
      updateTotalAndDiscount();
      return true;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return false;
    }
  }

  Future<bool> addOrderDetails(String address) async {
    List<CreateOrderProduct> temp = [];
    for (VerifiedProductsList i in (_checkOutData?.verifiedProductsList ?? [])) {
      temp.add(CreateOrderProduct(
          productId: i.productMetaDataDto!.productId,
          productMetaDataId: i.productMetaDataDto!.id,
          productQuantity: i.productQuantity));
    }

    AddOrderDetailsRequestModel dataform = AddOrderDetailsRequestModel(
        billingAddress: address,
        shippingAddress: address,
        paymentMode: selectedPaymentMethod,
        createOrderProduct: temp);
    try {
      dynamic tr =
          await _client_rep.callAddOrderDetailsApi(addOrderDetailsRequestModelToJson(dataform));
      _addOrderData = AddOrderDetailsResponseModel.fromJson(jsonDecode(tr.body));
      return true;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return false;
    }
  }

  Future<void> orderPlacedBackend({BuildContext? context}) async {
    if (context != null) _context = context;
    Navigator.pushNamed(_context!, Routes.orderPlacedScreen);
    await Future.delayed(Duration(seconds: 4));
    Navigator.pop(_context!);
    Navigator.pushNamedAndRemoveUntil(_context!, Routes.ClientScreen, (route) => false);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.toString()}");
    orderPlacedBackend();
    // Handle successful payment here
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    // Handle payment error here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
    // Handle external wallet selection here
  }

  initializePayment(String mobile, String email, String address, BuildContext context) async {
    _context = context;
    if (selectedPaymentMethod == 'Online') {
      await addOrderDetails(address);
      // print('dsfsadfs');
      // dynamic temp = await RazorpayApiServices().razorPayApi(100, 'dsfsdfsdafsdfsda');
      var options = {
        'key': ApiConstants.razorpayKey,
        'amount': _addOrderData!.razorpayOrderDto!.amount, //in the smallest currency sub-unit.
        'name': 'DotCom',
        "currency": _addOrderData!.razorpayOrderDto!.currency,
        'order_id': _addOrderData!.razorpayOrderDto!.id, // Generate order_id using Orders API
        // 'description': 'Fine T-Shirt',
        'timeout': 300, // in seconds
        'prefill': {'contact': mobile, 'email': email}
      };

      // print(temp['body']);
      Razorpay _razorpay = Razorpay();
      try {
        // print('dsfsadfs');
        _razorpay.open(options);
        _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      } catch (e) {
        print('Error: ${e.toString()}');
      }
    } else {}
  }
}

// class RazorpayApiServices {
//   final razorPayKey = 'rzp_test_XETURsaY2qkuB3';
//   final razorPaySecret = 'vYCdQceW07t1Mr6yvAIuhXxn';
//
//   razorPayApi(num amount, String receiptId) async {
//     var auth = 'Basic ' + base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'));
//     var headers = {'content-type': 'application/json', 'Authorization': auth};
//     var request = http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
//     request.body = json.encode({
//       "amount": amount * 100,
//       // Currency
//       "currency": "INR",
//       // Receipt Id
//       "receipt": receiptId
//     });
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       return {"status": "success", "body": jsonDecode(await response.stream.bytesToString())};
//     } else {
//       return {"status": "fail", "message": (response.reasonPhrase)};
//     }
//   }
// }
