import 'package:dot_com/admin/advertisement/repository/advertisement_detail_model.dart';
import 'package:dot_com/admin/advertisement/repository/product_model.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/error/failure.dart';
import '../../subadmin/data/datasources/subadmin_datasource_admin.dart';
import 'advertisement_urls.dart';

class AdvertisementRepository {
  Future<Either<Failure, List<ProductDetails>>> getAllProducts(
      {required int pageNo, required int pageSize}) async {
    return await post<List<ProductDetails>>(
      onSuccess: (data) {
        return productDetailsDtoFromJson(data);
      },
      body: {},
      url: AdvertisementsURLs.getAllProductDetails(
        pageNo: pageNo,
        pageSize: pageSize,
      ),
    );
  }

  Future<Either<Failure, String>> addAdvertisement(
      {required String imageUrl, required int productId}) async {
    return await post<String>(
      onSuccess: (data) {
        return data;
      },
      body: {"bannerUrl": imageUrl, "productId": productId},
      url: AdvertisementsURLs.addAdvertisement(),
    );
  }

  Future<Either<Failure, List<AdvertisementDetailsDto>>> getAllAdvertisements(
      {required int pageNo, required int pageSize}) async {
    return await get<List<AdvertisementDetailsDto>>(
      onSuccess: (data) {
        return advertisementDetailsDtoFromJson(data);
      },
      url: AdvertisementsURLs.getAllAdvertisement(
        pageNo: pageNo,
        pageSize: pageSize,
      ),
    );
  }

  Future<Either<Failure, String>> deleteAdvertisement(
      {required int id}) async {
    return await put<String>(
      onSuccess: (data) {
        return data;
      },
      body: {},
      url: AdvertisementsURLs.deleteAdvertisement(
        id: id
      ),
    );
  }
}
