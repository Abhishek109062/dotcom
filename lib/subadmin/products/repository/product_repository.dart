import 'package:dot_com/subadmin/products/repository/add_product_metadata_model.dart';
import 'package:dot_com/subadmin/products/repository/add_product_model.dart';
import 'package:dot_com/subadmin/products/repository/product_metadata_model_subadmin.dart';
import 'package:dot_com/subadmin/products/repository/product_model_subadmin.dart';
import 'package:dot_com/subadmin/products/repository/product_urls.dart';
import 'package:fpdart/fpdart.dart';

import '../../../admin/subadmin/data/datasources/subadmin_datasource_admin.dart';
import '../../../core/error/failure.dart';

class ProductRepository {
  Future<Either<Failure, ProductDetails>> addProduct(AddProduct newProduct) async {
    return await post<ProductDetails>(
        onSuccess: (data) {
          return ProductDetails.fromJson(data);
        },
        body: newProduct.toJson(),
        url: ProductUrls.addProduct());
  }

  Future<Either<Failure, ProductDetails>> getProduct({required int productId}) async {
    return await get<ProductDetails>(
        onSuccess: (data) {
          return ProductDetails.fromJson(data);
        },
        url: ProductUrls.getProduct(productId: productId));
  }

  Future<Either<Failure, ProductMetadataDto>> addProductMetadata(
      {required int productId, required AddProductMetadata metadata}) async {
    return await post<ProductMetadataDto>(
        onSuccess: (data) {
          return ProductMetadataDto.fromJson(data);
        },
        body: metadata.toJson(),
        url: ProductUrls.addProductMetadata(productId: productId));
  }

  Future<Either<Failure, ProductMetadataDto>> getProductMetadata(
      {required int productMetadataId}) async {
    return await get<ProductMetadataDto>(
        onSuccess: (data) {
          return ProductMetadataDto.fromJson(data);
        },
        url: ProductUrls.getProductMetadata(productMetadataId: productMetadataId));
  }

  Future<Either<Failure, List<ProductDetails>>> getAllProductDetails(
      {required int pageNo,
      required int pageSize,
      String searchString = "",
      List<String> filters = const []}) async {
    return await post<List<ProductDetails>>(
        onSuccess: (data) {
          return productDetailsDtoFromJson(data);
        },
        body: {"filters": filters},
        url: ProductUrls.getAllProductDetails(pageSize: pageSize, pageNo: pageNo,searchString: searchString));
  }

  Future<Either<Failure, List<ProductMetadataDto>>> getAllProductMetadata(
      {required int productId}) async {
    return await get<List<ProductMetadataDto>>(
        onSuccess: (data) {
          return productMetadataDtoFromJson(data);
        },
        url: ProductUrls.getAllProductMetadata(productId: productId));
  }

  Future<Either<Failure, ProductDetails>> updateProduct(
      {required ProductDetails updatedProduct}) async {
    return await put<ProductDetails>(
        onSuccess: (data) {
          return ProductDetails.fromJson(data);
        },
        body: updatedProduct.updateProduct(),
        url: ProductUrls.updateProduct());
  }

  Future<Either<Failure, ProductMetadataDto>> updateProductMetadata(
      {required ProductMetadataDto updatedProductMetadata}) async {
    return await put<ProductMetadataDto>(
        onSuccess: (data) {
          return ProductMetadataDto.fromJson(data);
        },
        body: updatedProductMetadata.updateMetadata(),
        url: ProductUrls.updateProductMetaData());
  }

  Future<Either<Failure, String>> deleteProduct(
      {required int productId}) async {
    return await put<String>(
        onSuccess: (data) {
          return "Success";
        },
        body: {},
        url: ProductUrls.deleteProduct(productId: productId));
  }

  Future<Either<Failure, String>> deleteProductMedadata(
      {required int productMetadataId}) async {
    return await put<String>(
        onSuccess: (data) {
          return "Success";
        },
        body: {},
        url: ProductUrls.deleteProductMetadata(productMetadataId: productMetadataId));
  }


}
