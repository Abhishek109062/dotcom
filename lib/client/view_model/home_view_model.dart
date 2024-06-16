import 'dart:convert';
import 'dart:io';

import 'package:dot_com/client/repository/client_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart' as ImagePick;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/user/user_model.dart';
import '../api_model/product_details_model.dart';

class HomeViewModel with ChangeNotifier {
  final _client_rep = ClientRepository();
  int _selectedCategory = 0;
  int _selectedLocation = 0;
  bool _isCategoryOpened = false;
  bool _isLocationOpened = false;
  bool _isLoadingMore = false;
  bool _isLoading = false;
  late UserDetails _userDetails;
  int _pageNo = 1;
  int pageSize = 8;
  String _gender = "";
  String _filters = "";
  String _sizes = "";
  String _color = "";
  bool _loggedIn = false;
  UserDetails get userDetails => _userDetails;
  List<ProductDetails> _allProducts = [];
  List<dynamic> advertisementsData = [];
  get client_rep => _client_rep;
  bool get isLoading => _isLoading;
  String get filters => _filters;

  String get sizes => _sizes;

  String get color => _color;
  String get gender => _gender;
  List<ProductDetails> get allProducts => _allProducts;

  final ImagePick.ImagePicker picker = ImagePick.ImagePicker();
  ImagePick.XFile? image;

  bool get isLoadingMore => _isLoadingMore;

  bool get loggedIn => _loggedIn;

  int get selectedCategory => _selectedCategory;

  bool get isCategoryOpened => _isCategoryOpened;

  bool get isLocationOpened => _isLocationOpened;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set allProducts(List<ProductDetails> value) {
    _allProducts = value;
  }

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  set isLocationOpened(bool value) {
    _isLocationOpened = value;
    notifyListeners();
  }

  set isCategoryOpened(bool value) {
    _isCategoryOpened = value;
    notifyListeners();
  }

  set selectedLocation(value) {
    _selectedLocation = value;
    notifyListeners();
  }

  set selectedCategory(value) {
    _selectedCategory = value;
    notifyListeners();
  }

  set filters(String value) {
    _filters = value;
    notifyListeners();
  }

  set sizes(String value) {
    _sizes = value;
    notifyListeners();
  }

  set color(String value) {
    _color = value;
    notifyListeners();
  }

  set gender(String value) {
    _gender = value;
    notifyListeners();
  }

  isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if ((prefs.getString('token') ?? '') != '') _loggedIn = true;
  }

  Future<void> getImage(ImagePick.ImageSource media) async {
    ImagePick.XFile? pickedImage = await picker.pickImage(source: media);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      int maxSizeBytes = 5 * 1024 * 1024; // 5MB
      print(await imageFile.length());
      // Check if image size exceeds 5MB
      if (await imageFile.length() > maxSizeBytes) {
        throw Exception('Image size exceeds 5MB');
      }
      await uploadProfilePic(imageFile);
      // Read image bytes
      // List<int> imageBytes = await pickedImage.readAsBytes();
      //
      // // Encode image to base64
      // String base64String = base64Encode(imageBytes);
      //
      // return base64String;
    }
  }

  Future<void> initialPage() async {
    isLoading = true;
    _allProducts = [];
    _pageNo = 1;
    _selectedLocation = 0;
    _selectedCategory = 0;
    // gender = "";
    // filters = "";
    // color = "";
    // sizes = "";
    // await Future.delayed(Duration(seconds: 10));
    await isUserLoggedIn();
    if (_loggedIn) await getUserDetails();
    await getAdvertisements();
    await getAllProductsHome();
    isLoading = false;
  }

  loadingMoreProductsTriggered() async {
    _isLoadingMore = true;
    notifyListeners();
    _pageNo++;
    await getAllProductsHome();

    _isLoadingMore = false;
    notifyListeners();
  }

  int get selectedLocation => _selectedLocation;

  void clearAllFilters() {
    gender = "";
    filters = "";
    color = "";
    sizes = "";
    notifyListeners();
  }

  Future<void> getUserDetails() async {
    dynamic temp = await _client_rep.callGetUserApi().then((value) async {
      print(value.body);
      _userDetails = UserDetails.fromJson(jsonDecode(value.body));

      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error coming here --${e.toString()}");
    });
  }

  Future<void> updateUserDetails(Map<String, dynamic> data) async {
    dynamic temp = await _client_rep.callUpdateCustomerDetailsApi(data).then((value) async {
      print(value.body);
      await getUserDetails();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  List<String> getFilters() {
    List<String> temp = [];
    if (gender != "") temp.add(gender);
    if (filters != "") temp.add(filters);
    if (sizes != "") temp.add(sizes);
    if (color != "") temp.add(color);
    return temp;
  }

  Future<void> getAllProductsHome() async {
    print("logged In $loggedIn");
    Map<String, dynamic> filterTemp = {
      "filters": getFilters(),
    };
    // categories_list[selectedCategory]['code']
    dynamic temp = await _client_rep
        .callGetAllProductsHomeApi(_pageNo, pageSize, '', '', loggedIn, filterTemp)
        .then((value) async {
      dynamic store = jsonDecode(value.body);
      // print('gone here');
      for (var productData in store) {
        print(store);
        _allProducts.add(ProductDetails.fromJson(productData));
      }
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error comming--${e.toString()}");
    });
  }

  Future<void> getAdvertisements() async {
    // print("logged In $loggedIn");
    // categories_list[selectedCategory]['code']
    dynamic temp = await _client_rep.callGetAdvertisementApi(loggedIn).then((value) async {
      advertisementsData = jsonDecode(value.body);
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error comming--${e.toString()}");
    });
  }

  Future<void> addProductToWishList(int productId) async {
    dynamic temp = await _client_rep.callAddProductToWishlistApi(productId).then((value) async {
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> deleteProductToWishList(int productId) async {
    dynamic temp = await _client_rep.callDeleteProductToWishlistApi(productId).then((value) async {
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> uploadProfilePic(File file) async {
    dynamic temp = await _client_rep.callUploadFileApi(file).then((value) async {
      await updateUserDetails({'profilePicUrl': jsonDecode(value.body)});
      await getUserDetails();
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
    ;
  }
}
