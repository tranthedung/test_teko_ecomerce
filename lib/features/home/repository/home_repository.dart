import 'package:ecomerce/base_utils/base_repository/base_repository.dart';
import 'package:ecomerce/base_utils/controller_base/base_controller.dart';
import 'package:ecomerce/core/enum/enum_request_method.dart';
import 'package:ecomerce/core/values/app_url.dart';
import 'package:ecomerce/features/home/models/models_src.dart';

class HomeRepository extends BaseRepository {
  HomeRepository(BaseGetxController controller) : super(controller);

  ///Apt getProducts.
  Future<List<ProductsModel>> getProducts() async {
    var response = await baseSendRequest(
      AppUrl.getProducts,
      EnumRequestMethod.get,
    );
    return List<ProductsModel>.from(
      response.map(
        (x) => ProductsModel.fromJson(x),
      ),
    );
  }

  ///Api getColors.
  Future<List<ColorsModel>> getColors() async {
    var response = await baseSendRequest(
      AppUrl.getColors,
      EnumRequestMethod.get,
    );
    return List<ColorsModel>.from(
      response.map(
        (x) => ColorsModel.fromJson(x),
      ),
    );
  }
}
