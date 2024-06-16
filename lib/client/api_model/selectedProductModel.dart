class SelectedProductModel {
  String size;
  String color;
  int id;
  int price;
  int quantity;
  List<String> productImgUrls;

  SelectedProductModel(
      {required this.size,
      required this.color,
      required this.id,
      required this.price,
      required this.quantity,
      required this.productImgUrls});
}
