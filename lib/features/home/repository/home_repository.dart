import 'package:ecomerce/base_utils/base_repository/base_repository.dart';
import 'package:ecomerce/base_utils/controller_base/base_controller.dart';
import 'package:ecomerce/core/enum/enum_request_method.dart';
import 'package:ecomerce/core/values/app_url.dart';
import 'package:ecomerce/features/home/models/products_model.dart';

class HomeRepository extends BaseRepository {
  HomeRepository(BaseGetxController controller) : super(controller);

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
}
