import 'package:dot_com/constants.dart';

class ProductUrls {
  //METHOD POST
  static addProduct() => "${ApiConstants.baseUrl}/subAdmin/addProduct";

  //METHOD GET
  static getProduct({required int productId}) =>
      "${ApiConstants.baseUrl}/subAdmin/getProduct?productId=$productId";

  //METHOD POST
  static addProductMetadata({required int productId}) =>
      "${ApiConstants.baseUrl}/subAdmin/addProductMetadata?productId=$productId";

  //METHOD GET
  static getProductMetadata({required int productMetadataId}) =>
      "${ApiConstants.baseUrl}/subAdmin/getProductMetadataById?productMetaDataId=$productMetadataId";

  //METHOD POST
  static getAllProductDetails(
          {required int pageNo, required int pageSize, String searchString = ""}) =>
      "${ApiConstants.baseUrl}/subAdmin/getProductDetailsWithPagination?pageNo=$pageNo&pageSize=$pageSize${searchString == "" ? "" : "&searchString=$searchString"}";

  //METHOD GET
  static getAllProductMetadata({required int productId}) =>
      "${ApiConstants.baseUrl}/subAdmin/getAllProductMetadata?productId=$productId";

  //METHOD GET
  static getProductMetaDataById({required int productMetadataId}) =>
      "${ApiConstants.baseUrl}/subAdmin/getProductMetadataById?productMetaDataId=$productMetadataId";

  //METHOD PUT
  static updateProduct() => "${ApiConstants.baseUrl}/subAdmin/updateProduct";

  //METHOD PUT
  static updateProductMetaData() => "${ApiConstants.baseUrl}/subAdmin/updateProductMetadata";

  //METHOD PUT
  static deleteProduct({required int productId}) =>
      "${ApiConstants.baseUrl}/subAdmin/deleteProduct?productId=$productId";

  //METHOD PUT
  static deleteProductMetadata({required int productMetadataId}) =>
      "${ApiConstants.baseUrl}/subAdmin/deleteProductMetadata?productMetaDataId=$productMetadataId";
}
